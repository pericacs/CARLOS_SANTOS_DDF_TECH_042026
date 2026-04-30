from pathlib import Path

import pandas as pd
import plotly.express as px
import streamlit as st


BASE_DIR = Path(__file__).resolve().parents[1]
RAW_DIR = BASE_DIR / "data" / "raw"


st.set_page_config(
    page_title="E-commerce Olist Analytics",
    page_icon="📊",
    layout="wide",
)


@st.cache_data
def carregar_dados():
    orders = pd.read_csv(RAW_DIR / "olist_orders_dataset.csv")
    order_items = pd.read_csv(RAW_DIR / "olist_order_items_dataset.csv")
    customers = pd.read_csv(RAW_DIR / "olist_customers_dataset.csv")
    products = pd.read_csv(RAW_DIR / "olist_products_dataset.csv")
    reviews = pd.read_csv(RAW_DIR / "olist_order_reviews_dataset.csv")
    payments = pd.read_csv(RAW_DIR / "olist_order_payments_dataset.csv")
    sellers = pd.read_csv(RAW_DIR / "olist_sellers_dataset.csv")

    category_path = RAW_DIR / "product_category_name_translation.csv"

    if category_path.exists():
        category_translation = pd.read_csv(category_path)
    else:
        category_translation = pd.DataFrame(
            columns=["product_category_name", "product_category_name_english"]
        )

    return {
        "orders": orders,
        "order_items": order_items,
        "customers": customers,
        "products": products,
        "reviews": reviews,
        "payments": payments,
        "sellers": sellers,
        "category_translation": category_translation,
    }


def preparar_base_analitica(dados):
    orders = dados["orders"].copy()
    order_items = dados["order_items"].copy()
    customers = dados["customers"].copy()
    products = dados["products"].copy()
    reviews = dados["reviews"].copy()
    payments = dados["payments"].copy()
    category_translation = dados["category_translation"].copy()

    orders["order_purchase_timestamp"] = pd.to_datetime(
        orders["order_purchase_timestamp"],
        errors="coerce",
    )
    orders["order_delivered_customer_date"] = pd.to_datetime(
        orders["order_delivered_customer_date"],
        errors="coerce",
    )
    orders["order_estimated_delivery_date"] = pd.to_datetime(
        orders["order_estimated_delivery_date"],
        errors="coerce",
    )

    orders["ano_mes"] = orders["order_purchase_timestamp"].dt.to_period("M").astype(str)
    orders["data_compra"] = orders["order_purchase_timestamp"].dt.date

    orders["dias_ate_entrega"] = (
        orders["order_delivered_customer_date"] - orders["order_purchase_timestamp"]
    ).dt.days

    orders["dias_atraso"] = (
        orders["order_delivered_customer_date"] - orders["order_estimated_delivery_date"]
    ).dt.days

    orders["flag_entrega_atrasada"] = (
        orders["order_delivered_customer_date"] > orders["order_estimated_delivery_date"]
    ).astype(int)

    itens_agg = (
        order_items.groupby(["order_id", "product_id", "seller_id"], as_index=False)
        .agg(
            quantidade_itens=("order_item_id", "count"),
            valor_produtos=("price", "sum"),
            valor_frete=("freight_value", "sum"),
        )
    )

    itens_agg["valor_total_pedido"] = (
        itens_agg["valor_produtos"] + itens_agg["valor_frete"]
    )

    produtos = products.merge(
        category_translation,
        on="product_category_name",
        how="left",
    )

    produtos["product_category_name_english"] = produtos[
        "product_category_name_english"
    ].fillna(produtos["product_category_name"])

    reviews_reduzido = reviews[
        [
            "order_id",
            "review_score",
            "review_comment_message",
        ]
    ].copy()

    reviews_reduzido["classificacao_review"] = reviews_reduzido["review_score"].apply(
        classificar_review
    )

    reviews_reduzido["flag_review_negativo"] = (
        reviews_reduzido["review_score"] <= 2
    ).astype(int)

    payments_agg = (
        payments.groupby("order_id", as_index=False)
        .agg(
            valor_pago=("payment_value", "sum"),
            parcelas_medias=("payment_installments", "mean"),
            qtd_pagamentos=("payment_sequential", "count"),
        )
    )

    base = (
        orders.merge(customers, on="customer_id", how="left")
        .merge(itens_agg, on="order_id", how="left")
        .merge(produtos, on="product_id", how="left")
        .merge(reviews_reduzido, on="order_id", how="left")
        .merge(payments_agg, on="order_id", how="left")
    )

    base["categoria"] = base["product_category_name_english"].fillna("Sem categoria")
    base["estado_cliente"] = base["customer_state"].fillna("N/A")
    base["valor_total_pedido"] = base["valor_total_pedido"].fillna(0)
    base["review_score"] = base["review_score"].fillna(0)

    return base


def classificar_review(score):
    if pd.isna(score):
        return "Sem review"

    if score <= 2:
        return "Negativo"

    if score == 3:
        return "Neutro"

    if score >= 4:
        return "Positivo"

    return "Sem review"


def aplicar_filtros(base):
    st.sidebar.header("Filtros")

    estados = sorted(base["estado_cliente"].dropna().unique().tolist())
    categorias = sorted(base["categoria"].dropna().unique().tolist())
    status = sorted(base["order_status"].dropna().unique().tolist())

    estado_selecionado = st.sidebar.multiselect(
        "Estado do cliente",
        estados,
        default=[],
    )

    categoria_selecionada = st.sidebar.multiselect(
        "Categoria do produto",
        categorias,
        default=[],
    )

    status_selecionado = st.sidebar.multiselect(
        "Status do pedido",
        status,
        default=[],
    )

    base_filtrada = base.copy()

    if estado_selecionado:
        base_filtrada = base_filtrada[
            base_filtrada["estado_cliente"].isin(estado_selecionado)
        ]

    if categoria_selecionada:
        base_filtrada = base_filtrada[
            base_filtrada["categoria"].isin(categoria_selecionada)
        ]

    if status_selecionado:
        base_filtrada = base_filtrada[
            base_filtrada["order_status"].isin(status_selecionado)
        ]

    return base_filtrada


def exibir_kpis(base):
    total_pedidos = base["order_id"].nunique()
    faturamento = base["valor_total_pedido"].sum()
    ticket_medio = faturamento / total_pedidos if total_pedidos else 0
    percentual_atraso = base["flag_entrega_atrasada"].mean() * 100
    nota_media = base.loc[base["review_score"] > 0, "review_score"].mean()

    col1, col2, col3, col4, col5 = st.columns(5)

    col1.metric("Total de pedidos", f"{total_pedidos:,.0f}".replace(",", "."))
    col2.metric("Faturamento", f"R$ {faturamento:,.2f}")
    col3.metric("Ticket médio", f"R$ {ticket_medio:,.2f}")
    col4.metric("Entregas atrasadas", f"{percentual_atraso:.2f}%")
    col5.metric("Nota média", f"{nota_media:.2f}" if pd.notna(nota_media) else "N/A")


def grafico_faturamento_mensal(base):
    df = (
        base.groupby("ano_mes", as_index=False)
        .agg(faturamento_total=("valor_total_pedido", "sum"))
        .sort_values("ano_mes")
    )

    fig = px.line(
        df,
        x="ano_mes",
        y="faturamento_total",
        markers=True,
        title="Evolução do faturamento mensal",
    )

    st.plotly_chart(fig, use_container_width=True)


def grafico_pedidos_estado(base):
    df = (
        base.groupby("estado_cliente", as_index=False)
        .agg(total_pedidos=("order_id", "nunique"))
        .sort_values("total_pedidos", ascending=False)
        .head(15)
    )

    fig = px.bar(
        df,
        x="estado_cliente",
        y="total_pedidos",
        title="Pedidos por estado do cliente",
    )

    st.plotly_chart(fig, use_container_width=True)


def grafico_faturamento_categoria(base):
    df = (
        base.groupby("categoria", as_index=False)
        .agg(faturamento_total=("valor_total_pedido", "sum"))
        .sort_values("faturamento_total", ascending=False)
        .head(15)
    )

    fig = px.bar(
        df,
        x="faturamento_total",
        y="categoria",
        orientation="h",
        title="Top 15 categorias por faturamento",
    )

    st.plotly_chart(fig, use_container_width=True)


def grafico_reviews_categoria(base):
    df = base[base["review_score"] > 0].copy()

    df = (
        df.groupby("categoria", as_index=False)
        .agg(
            nota_media=("review_score", "mean"),
            total_reviews=("review_score", "count"),
        )
        .query("total_reviews >= 20")
        .sort_values("nota_media", ascending=True)
        .head(15)
    )

    fig = px.bar(
        df,
        x="nota_media",
        y="categoria",
        orientation="h",
        title="Categorias com pior nota média",
    )

    st.plotly_chart(fig, use_container_width=True)


def grafico_atraso_review(base):
    df = base[base["review_score"] > 0].copy()

    df["situacao_entrega"] = df["flag_entrega_atrasada"].apply(
        lambda x: "Atrasada" if x == 1 else "No prazo"
    )

    df = (
        df.groupby(["situacao_entrega", "classificacao_review"], as_index=False)
        .agg(total_reviews=("review_score", "count"))
    )

    fig = px.bar(
        df,
        x="situacao_entrega",
        y="total_reviews",
        color="classificacao_review",
        barmode="group",
        title="Relação entre atraso de entrega e classificação do review",
    )

    st.plotly_chart(fig, use_container_width=True)


def exibir_tabela_reviews(base):
    st.subheader("Amostra de comentários de clientes")

    colunas = [
        "order_id",
        "estado_cliente",
        "categoria",
        "review_score",
        "classificacao_review",
        "review_comment_message",
    ]

    df = base[colunas].copy()
    df = df[df["review_comment_message"].notna()]
    df = df[df["review_comment_message"].astype(str).str.strip() != ""]

    st.dataframe(df.head(100), use_container_width=True)


def main():
    st.title("📊 E-commerce Olist Analytics")
    st.write(
        "Data App criado para exploração analítica da base Olist, com foco em vendas, logística e experiência do cliente."
    )

    try:
        dados = carregar_dados()
        base = preparar_base_analitica(dados)
    except FileNotFoundError as erro:
        st.error("Arquivos da base Olist não encontrados.")
        st.write("Coloque os arquivos CSV na pasta `data/raw/` antes de executar o app.")
        st.code(str(erro))
        st.stop()

    base_filtrada = aplicar_filtros(base)

    exibir_kpis(base_filtrada)

    st.divider()

    col1, col2 = st.columns(2)

    with col1:
        grafico_faturamento_mensal(base_filtrada)

    with col2:
        grafico_pedidos_estado(base_filtrada)

    col3, col4 = st.columns(2)

    with col3:
        grafico_faturamento_categoria(base_filtrada)

    with col4:
        grafico_reviews_categoria(base_filtrada)

    grafico_atraso_review(base_filtrada)

    st.divider()

    exibir_tabela_reviews(base_filtrada)


if __name__ == "__main__":
    main()