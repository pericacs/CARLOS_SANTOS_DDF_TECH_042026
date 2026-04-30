from pathlib import Path
import json
import pandas as pd
import great_expectations as gx
from great_expectations.core.batch import RuntimeBatchRequest


BASE_DIR = Path(__file__).resolve().parents[1]
RAW_DIR = BASE_DIR / "data" / "raw"
REPORT_DIR = BASE_DIR / "data_quality" / "reports"
GE_DIR = BASE_DIR / "data_quality" / "great_expectations"

REPORT_DIR.mkdir(parents=True, exist_ok=True)
GE_DIR.mkdir(parents=True, exist_ok=True)


ARQUIVOS = {
    "orders": "olist_orders_dataset.csv",
    "order_items": "olist_order_items_dataset.csv",
    "customers": "olist_customers_dataset.csv",
    "products": "olist_products_dataset.csv",
    "payments": "olist_order_payments_dataset.csv",
    "reviews": "olist_order_reviews_dataset.csv",
    "sellers": "olist_sellers_dataset.csv",
}


def carregar_csv(nome_arquivo: str) -> pd.DataFrame:
    caminho = RAW_DIR / nome_arquivo

    if not caminho.exists():
        raise FileNotFoundError(f"Arquivo não encontrado: {caminho}")

    return pd.read_csv(caminho)


def criar_contexto_ge():
    context = gx.get_context(context_root_dir=str(GE_DIR))

    datasource_name = "olist_pandas_datasource"

    existing_datasources = [ds["name"] for ds in context.list_datasources()]

    if datasource_name not in existing_datasources:
        datasource_config = {
            "name": datasource_name,
            "class_name": "Datasource",
            "execution_engine": {
                "class_name": "PandasExecutionEngine",
            },
            "data_connectors": {
                "runtime_data_connector": {
                    "class_name": "RuntimeDataConnector",
                    "batch_identifiers": ["default_identifier_name"],
                }
            },
        }

        context.add_datasource(**datasource_config)

    return context


def obter_validator(context, df: pd.DataFrame, nome_tabela: str):
    suite_name = f"suite_{nome_tabela}"

    context.add_or_update_expectation_suite(expectation_suite_name=suite_name)

    batch_request = RuntimeBatchRequest(
        datasource_name="olist_pandas_datasource",
        data_connector_name="runtime_data_connector",
        data_asset_name=nome_tabela,
        runtime_parameters={"batch_data": df},
        batch_identifiers={"default_identifier_name": nome_tabela},
    )

    validator = context.get_validator(
        batch_request=batch_request,
        expectation_suite_name=suite_name,
    )

    return validator


def validar_orders(context):
    df = carregar_csv(ARQUIVOS["orders"])
    validator = obter_validator(context, df, "orders")

    validator.expect_table_row_count_to_be_between(min_value=90000)
    validator.expect_column_values_to_not_be_null("order_id")
    validator.expect_column_values_to_be_unique("order_id")
    validator.expect_column_values_to_not_be_null("customer_id")
    validator.expect_column_values_to_not_be_null("order_status")
    validator.expect_column_values_to_be_in_set(
        "order_status",
        [
            "delivered",
            "shipped",
            "canceled",
            "invoiced",
            "processing",
            "unavailable",
            "approved",
            "created",
        ],
    )

    validator.expect_column_values_to_not_be_null("order_purchase_timestamp")

    validator.save_expectation_suite(discard_failed_expectations=False)

    return validator.validate()


def validar_order_items(context):
    df = carregar_csv(ARQUIVOS["order_items"])
    validator = obter_validator(context, df, "order_items")

    validator.expect_table_row_count_to_be_between(min_value=90000)
    validator.expect_column_values_to_not_be_null("order_id")
    validator.expect_column_values_to_not_be_null("order_item_id")
    validator.expect_column_values_to_not_be_null("product_id")
    validator.expect_column_values_to_not_be_null("seller_id")
    validator.expect_column_values_to_not_be_null("price")
    validator.expect_column_values_to_not_be_null("freight_value")
    validator.expect_column_values_to_be_between("price", min_value=0)
    validator.expect_column_values_to_be_between("freight_value", min_value=0)

    validator.save_expectation_suite(discard_failed_expectations=False)

    return validator.validate()


def validar_customers(context):
    df = carregar_csv(ARQUIVOS["customers"])
    validator = obter_validator(context, df, "customers")

    validator.expect_table_row_count_to_be_between(min_value=90000)
    validator.expect_column_values_to_not_be_null("customer_id")
    validator.expect_column_values_to_be_unique("customer_id")
    validator.expect_column_values_to_not_be_null("customer_unique_id")
    validator.expect_column_values_to_not_be_null("customer_city")
    validator.expect_column_values_to_not_be_null("customer_state")

    validator.save_expectation_suite(discard_failed_expectations=False)

    return validator.validate()


def validar_products(context):
    df = carregar_csv(ARQUIVOS["products"])
    validator = obter_validator(context, df, "products")

    validator.expect_column_values_to_not_be_null("product_id")
    validator.expect_column_values_to_be_unique("product_id")
    validator.expect_column_values_to_be_between(
        "product_weight_g",
        min_value=0,
        mostly=0.95,
    )
    validator.expect_column_values_to_be_between(
        "product_length_cm",
        min_value=0,
        mostly=0.95,
    )
    validator.expect_column_values_to_be_between(
        "product_height_cm",
        min_value=0,
        mostly=0.95,
    )
    validator.expect_column_values_to_be_between(
        "product_width_cm",
        min_value=0,
        mostly=0.95,
    )

    validator.save_expectation_suite(discard_failed_expectations=False)

    return validator.validate()


def validar_payments(context):
    df = carregar_csv(ARQUIVOS["payments"])
    validator = obter_validator(context, df, "payments")

    validator.expect_table_row_count_to_be_between(min_value=90000)
    validator.expect_column_values_to_not_be_null("order_id")
    validator.expect_column_values_to_not_be_null("payment_type")
    validator.expect_column_values_to_not_be_null("payment_value")
    validator.expect_column_values_to_be_between("payment_value", min_value=0)
    validator.expect_column_values_to_be_between("payment_installments", min_value=0)
    validator.expect_column_values_to_be_in_set(
        "payment_type",
        [
            "credit_card",
            "boleto",
            "voucher",
            "debit_card",
            "not_defined",
        ],
    )

    validator.save_expectation_suite(discard_failed_expectations=False)

    return validator.validate()


def validar_reviews(context):
    df = carregar_csv(ARQUIVOS["reviews"])
    validator = obter_validator(context, df, "reviews")

    validator.expect_table_row_count_to_be_between(min_value=90000)
    validator.expect_column_values_to_not_be_null("review_id")
    validator.expect_column_values_to_not_be_null("order_id")
    validator.expect_column_values_to_not_be_null("review_score")
    validator.expect_column_values_to_be_between("review_score", min_value=1, max_value=5)

    validator.save_expectation_suite(discard_failed_expectations=False)

    return validator.validate()


def validar_sellers(context):
    df = carregar_csv(ARQUIVOS["sellers"])
    validator = obter_validator(context, df, "sellers")

    validator.expect_column_values_to_not_be_null("seller_id")
    validator.expect_column_values_to_be_unique("seller_id")
    validator.expect_column_values_to_not_be_null("seller_city")
    validator.expect_column_values_to_not_be_null("seller_state")

    validator.save_expectation_suite(discard_failed_expectations=False)

    return validator.validate()


def resultado_para_dict(nome_tabela, resultado):
    estatisticas = resultado["statistics"]

    return {
        "tabela": nome_tabela,
        "sucesso": bool(resultado["success"]),
        "expectativas_avaliadas": estatisticas["evaluated_expectations"],
        "expectativas_com_sucesso": estatisticas["successful_expectations"],
        "expectativas_com_falha": estatisticas["unsuccessful_expectations"],
        "percentual_sucesso": round(estatisticas["success_percent"], 2),
    }


def gerar_markdown(resumos):
    linhas = []

    linhas.append("# Relatório de Data Quality - Base Olist")
    linhas.append("")
    linhas.append("Este relatório apresenta o resultado das validações de qualidade de dados executadas com Great Expectations.")
    linhas.append("")
    linhas.append("As validações foram aplicadas sobre os arquivos CSV da base Olist armazenados localmente em `data/raw/`.")
    linhas.append("")
    linhas.append("---")
    linhas.append("")

    linhas.append("## 1. Resumo Executivo")
    linhas.append("")
    linhas.append("| Tabela | Sucesso | Expectativas Avaliadas | Sucesso | Falha | % Sucesso |")
    linhas.append("|---|---|---:|---:|---:|---:|")

    for item in resumos:
        linhas.append(
            f"| {item['tabela']} | {item['sucesso']} | "
            f"{item['expectativas_avaliadas']} | "
            f"{item['expectativas_com_sucesso']} | "
            f"{item['expectativas_com_falha']} | "
            f"{item['percentual_sucesso']}% |"
        )

    linhas.append("")
    linhas.append("---")
    linhas.append("")

    linhas.append("## 2. Regras Aplicadas")
    linhas.append("")
    linhas.append("As principais regras avaliadas foram:")
    linhas.append("")
    linhas.append("- Quantidade mínima de registros nas tabelas principais;")
    linhas.append("- Chaves técnicas e de negócio não nulas;")
    linhas.append("- Unicidade de identificadores principais;")
    linhas.append("- Valores monetários maiores ou iguais a zero;")
    linhas.append("- Scores de review entre 1 e 5;")
    linhas.append("- Status de pedidos dentro dos valores esperados;")
    linhas.append("- Tipos de pagamento dentro dos valores esperados;")
    linhas.append("- Campos geográficos obrigatórios preenchidos.")
    linhas.append("")

    linhas.append("---")
    linhas.append("")

    linhas.append("## 3. Conclusão")
    linhas.append("")
    linhas.append("A execução das validações de qualidade permite identificar inconsistências antes da criação das camadas tratadas e analíticas.")
    linhas.append("")
    linhas.append("Essas validações apoiam a governança dos dados e aumentam a confiabilidade das tabelas que serão utilizadas em dashboards, modelagem dimensional e Data Apps.")
    linhas.append("")

    return "\n".join(linhas)


def salvar_resultados_json(resultados):
    caminho = REPORT_DIR / "resultado_data_quality_olist.json"

    serializado = {}

    for nome_tabela, resultado in resultados.items():
        serializado[nome_tabela] = resultado.to_json_dict()

    caminho.write_text(
        json.dumps(serializado, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )

    print(f"Resultado JSON salvo em: {caminho}")


def main():
    print("Iniciando validações de Data Quality com Great Expectations...\n")

    context = criar_contexto_ge()

    validacoes = {
        "orders": validar_orders,
        "order_items": validar_order_items,
        "customers": validar_customers,
        "products": validar_products,
        "payments": validar_payments,
        "reviews": validar_reviews,
        "sellers": validar_sellers,
    }

    resultados = {}
    resumos = []

    for nome_tabela, funcao_validacao in validacoes.items():
        print(f"Validando tabela: {nome_tabela}")

        resultado = funcao_validacao(context)

        resultados[nome_tabela] = resultado
        resumos.append(resultado_para_dict(nome_tabela, resultado))

        print(f"Sucesso: {resultado['success']}")
        print("")

    salvar_resultados_json(resultados)

    markdown = gerar_markdown(resumos)

    caminho_markdown = REPORT_DIR / "relatorio_data_quality_olist.md"
    caminho_markdown.write_text(markdown, encoding="utf-8")

    print(f"Relatório Markdown salvo em: {caminho_markdown}")
    print("\nValidações finalizadas com sucesso.")


if __name__ == "__main__":
    main()