from pathlib import Path
import pandas as pd


BASE_DIR = Path(__file__).resolve().parents[1]
RAW_DIR = BASE_DIR / "data" / "raw"
REPORT_DIR = BASE_DIR / "data_quality" / "reports"
REPORT_DIR.mkdir(parents=True, exist_ok=True)

ARQUIVOS = {
    "orders": "olist_orders_dataset.csv",
    "order_items": "olist_order_items_dataset.csv",
    "customers": "olist_customers_dataset.csv",
    "products": "olist_products_dataset.csv",
    "payments": "olist_order_payments_dataset.csv",
    "reviews": "olist_order_reviews_dataset.csv",
    "sellers": "olist_sellers_dataset.csv",
    "geolocation": "olist_geolocation_dataset.csv",
    "category_translation": "product_category_name_translation.csv",
}


def validar_arquivos():
    print("Validando arquivos da base Olist...\n")

    arquivos_encontrados = []
    arquivos_ausentes = []

    for nome_tabela, arquivo in ARQUIVOS.items():
        caminho = RAW_DIR / arquivo

        if caminho.exists():
            arquivos_encontrados.append((nome_tabela, arquivo, caminho))
            print(f"[OK] {arquivo}")
        else:
            arquivos_ausentes.append((nome_tabela, arquivo))
            print(f"[AUSENTE] {arquivo}")

    if arquivos_ausentes:
        print("\nArquivos ausentes encontrados.")
        print("Baixe a base Olist no Kaggle e coloque os CSVs em data/raw/.")
        raise FileNotFoundError("Existem arquivos obrigatórios ausentes em data/raw/.")

    return arquivos_encontrados


def ler_csv(caminho):
    return pd.read_csv(caminho)


def gerar_resumo_tabela(nome_tabela, arquivo, df):
    total_linhas = len(df)
    total_colunas = len(df.columns)
    total_duplicadas = df.duplicated().sum()

    nulos = df.isna().sum()
    percentual_nulos = (nulos / total_linhas * 100).round(2)

    resumo_nulos = pd.DataFrame(
        {
            "coluna": nulos.index,
            "qtd_nulos": nulos.values,
            "perc_nulos": percentual_nulos.values,
            "tipo_dado": [str(df[col].dtype) for col in nulos.index],
        }
    )

    resumo_nulos = resumo_nulos.sort_values(
        by=["qtd_nulos", "coluna"],
        ascending=[False, True],
    )

    return {
        "nome_tabela": nome_tabela,
        "arquivo": arquivo,
        "total_linhas": total_linhas,
        "total_colunas": total_colunas,
        "total_duplicadas": int(total_duplicadas),
        "colunas": list(df.columns),
        "resumo_nulos": resumo_nulos,
    }


def dataframe_para_markdown(df, limite=20):
    if df.empty:
        return "Nenhum registro encontrado."

    return df.head(limite).to_markdown(index=False)


def gerar_relatorio_markdown(resumos):
    linhas = []

    linhas.append("# Relatório de Exploração Inicial - Base Olist")
    linhas.append("")
    linhas.append("Este relatório apresenta uma análise exploratória inicial dos arquivos CSV da base Olist.")
    linhas.append("")
    linhas.append("O objetivo é validar a estrutura dos dados, volume de registros, colunas disponíveis, dados nulos e possíveis duplicidades.")
    linhas.append("")
    linhas.append("---")
    linhas.append("")

    linhas.append("## 1. Resumo Geral")
    linhas.append("")
    linhas.append("| Tabela | Arquivo | Linhas | Colunas | Duplicadas |")
    linhas.append("|---|---|---:|---:|---:|")

    for resumo in resumos:
        linhas.append(
            f"| {resumo['nome_tabela']} | {resumo['arquivo']} | "
            f"{resumo['total_linhas']} | {resumo['total_colunas']} | {resumo['total_duplicadas']} |"
        )

    linhas.append("")
    linhas.append("---")
    linhas.append("")

    linhas.append("## 2. Detalhamento por Tabela")
    linhas.append("")

    for resumo in resumos:
        linhas.append(f"### 2.x {resumo['nome_tabela']}")
        linhas.append("")
        linhas.append(f"Arquivo: `{resumo['arquivo']}`")
        linhas.append("")
        linhas.append(f"Total de linhas: **{resumo['total_linhas']}**")
        linhas.append("")
        linhas.append(f"Total de colunas: **{resumo['total_colunas']}**")
        linhas.append("")
        linhas.append(f"Total de linhas duplicadas: **{resumo['total_duplicadas']}**")
        linhas.append("")
        linhas.append("Colunas:")
        linhas.append("")
        for coluna in resumo["colunas"]:
            linhas.append(f"- `{coluna}`")
        linhas.append("")
        linhas.append("Resumo de nulos por coluna:")
        linhas.append("")
        linhas.append(dataframe_para_markdown(resumo["resumo_nulos"]))
        linhas.append("")
        linhas.append("---")
        linhas.append("")

    linhas.append("## 3. Conclusão Inicial")
    linhas.append("")
    linhas.append("A base Olist possui volume suficiente para o case técnico, com múltiplas tabelas relacionadas ao processo de e-commerce.")
    linhas.append("")
    linhas.append("A partir desta exploração inicial, as próximas etapas serão:")
    linhas.append("")
    linhas.append("- carregar os arquivos na Dadosfera;")
    linhas.append("- catalogar os datasets;")
    linhas.append("- aplicar regras de Data Quality;")
    linhas.append("- construir as camadas Bronze, Silver e Gold;")
    linhas.append("- criar modelo dimensional;")
    linhas.append("- desenvolver dashboards e Data App.")
    linhas.append("")

    return "\n".join(linhas)


def main():
    arquivos = validar_arquivos()

    resumos = []

    for nome_tabela, arquivo, caminho in arquivos:
        print(f"\nLendo tabela: {nome_tabela}")
        df = ler_csv(caminho)

        resumo = gerar_resumo_tabela(nome_tabela, arquivo, df)
        resumos.append(resumo)

        print(f"Linhas: {resumo['total_linhas']}")
        print(f"Colunas: {resumo['total_colunas']}")
        print(f"Duplicadas: {resumo['total_duplicadas']}")

    relatorio = gerar_relatorio_markdown(resumos)

    caminho_relatorio = REPORT_DIR / "resumo_exploracao_olist.md"
    caminho_relatorio.write_text(relatorio, encoding="utf-8")

    print("\nRelatório gerado com sucesso:")
    print(caminho_relatorio)


if __name__ == "__main__":
    main()