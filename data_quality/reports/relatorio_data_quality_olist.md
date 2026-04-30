# Relatório de Data Quality - Base Olist

Este relatório apresenta o resultado das validações de qualidade de dados executadas com Great Expectations.

As validações foram aplicadas sobre os arquivos CSV da base Olist armazenados localmente em `data/raw/`.

---

## 1. Resumo Executivo

| Tabela | Sucesso | Expectativas Avaliadas | Sucesso | Falha | % Sucesso |
|---|---|---:|---:|---:|---:|
| orders | True | 7 | 7 | 0 | 100.0% |
| order_items | True | 9 | 9 | 0 | 100.0% |
| customers | True | 6 | 6 | 0 | 100.0% |
| products | True | 6 | 6 | 0 | 100.0% |
| payments | True | 7 | 7 | 0 | 100.0% |
| reviews | True | 5 | 5 | 0 | 100.0% |
| sellers | True | 4 | 4 | 0 | 100.0% |

---

## 2. Regras Aplicadas

As principais regras avaliadas foram:

- Quantidade mínima de registros nas tabelas principais;
- Chaves técnicas e de negócio não nulas;
- Unicidade de identificadores principais;
- Valores monetários maiores ou iguais a zero;
- Scores de review entre 1 e 5;
- Status de pedidos dentro dos valores esperados;
- Tipos de pagamento dentro dos valores esperados;
- Campos geográficos obrigatórios preenchidos.

---

## 3. Conclusão

A execução das validações de qualidade permite identificar inconsistências antes da criação das camadas tratadas e analíticas.

Essas validações apoiam a governança dos dados e aumentam a confiabilidade das tabelas que serão utilizadas em dashboards, modelagem dimensional e Data Apps.
