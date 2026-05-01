# Ordem de Execução dos Scripts SQL

## 1. Objetivo

Este documento define a ordem correta de execução dos scripts SQL do projeto.

A execução deve respeitar a arquitetura em camadas:

```text
PUBLIC.RAW_*
    ↓
PUBLIC.BRONZE_*
    ↓
PUBLIC.SILVER_*_ENRICHED
    ↓
PUBLIC.GOLD_*
```

As tabelas `PUBLIC.RAW_*` são criadas a partir da carga dos arquivos CSV na Dadosfera.  
Os scripts SQL começam a partir da camada Bronze.

---

## 2. Pré-requisitos

Antes de executar os scripts SQL, é necessário que as tabelas Raw estejam carregadas na Dadosfera:

| Tabela Raw | Origem |
|---|---|
| `PUBLIC.RAW_ORDERS` | `olist_orders_dataset.csv` |
| `PUBLIC.RAW_ORDER_ITEMS` | `olist_order_items_dataset.csv` |
| `PUBLIC.RAW_CUSTOMERS` | `olist_customers_dataset.csv` |
| `PUBLIC.RAW_PRODUCTS` | `olist_products_dataset.csv` |
| `PUBLIC.RAW_PAYMENTS` | `olist_order_payments_dataset.csv` |
| `PUBLIC.RAW_REVIEWS` | `olist_order_reviews_dataset.csv` |
| `PUBLIC.RAW_SELLERS` | `olist_sellers_dataset.csv` |

---

## 3. Etapa 1 — Executar camada Bronze

A camada Bronze padroniza tipos, datas, textos e cria colunas técnicas de controle.

Executar nesta ordem:

```text
sql/bronze/bronze_orders.sql
sql/bronze/bronze_customers.sql
sql/bronze/bronze_products.sql
sql/bronze/bronze_sellers.sql
sql/bronze/bronze_order_items.sql
sql/bronze/bronze_payments.sql
sql/bronze/bronze_reviews.sql
```

### Tabelas geradas

```text
PUBLIC.BRONZE_ORDERS
PUBLIC.BRONZE_CUSTOMERS
PUBLIC.BRONZE_PRODUCTS
PUBLIC.BRONZE_SELLERS
PUBLIC.BRONZE_ORDER_ITEMS
PUBLIC.BRONZE_PAYMENTS
PUBLIC.BRONZE_REVIEWS
```

---

## 4. Etapa 2 — Executar camada Silver

A camada Silver cria tabelas enriquecidas com regras de negócio, integrações e classificações.

Executar nesta ordem:

```text
sql/silver/silver_orders_enriched.sql
sql/silver/silver_order_items_enriched.sql
sql/silver/silver_payments_enriched.sql
sql/silver/silver_reviews_enriched.sql
```

### Tabelas geradas

```text
PUBLIC.SILVER_ORDERS_ENRICHED
PUBLIC.SILVER_ORDER_ITEMS_ENRICHED
PUBLIC.SILVER_PAYMENTS_ENRICHED
PUBLIC.SILVER_REVIEWS_ENRICHED
```

---

## 5. Etapa 3 — Executar dimensões Gold

As dimensões devem ser criadas antes das fatos, pois serão referenciadas por chaves substitutas.

Executar nesta ordem:

```text
sql/gold/dim_cliente.sql
sql/gold/dim_produto.sql
sql/gold/dim_vendedor.sql
sql/gold/dim_tempo.sql
```

### Tabelas geradas

```text
PUBLIC.GOLD_DIM_CLIENTE
PUBLIC.GOLD_DIM_PRODUTO
PUBLIC.GOLD_DIM_VENDEDOR
PUBLIC.GOLD_DIM_TEMPO
```

---

## 6. Etapa 4 — Executar fatos Gold

As fatos dependem das dimensões e das tabelas Silver.

Executar nesta ordem:

```text
sql/gold/fato_pedidos.sql
sql/gold/fato_pagamentos.sql
sql/gold/fato_reviews.sql
```

### Tabelas geradas

```text
PUBLIC.GOLD_FATO_PEDIDOS
PUBLIC.GOLD_FATO_PAGAMENTOS
PUBLIC.GOLD_FATO_REVIEWS
```

---

## 7. Etapa 5 — Executar views analíticas Gold

As views devem ser executadas por último, pois dependem das dimensões e fatos Gold.

Executar nesta ordem:

```text
sql/gold/vw_ecommerce_performance_comercial.sql
sql/gold/vw_ecommerce_experiencia_cliente.sql
```

### Views geradas

```text
PUBLIC.GOLD_VW_ECOMMERCE_PERFORMANCE_COMERCIAL
PUBLIC.GOLD_VW_ECOMMERCE_EXPERIENCIA_CLIENTE
```

---

## 8. Resumo da Ordem Completa

```text
1. sql/bronze/bronze_orders.sql
2. sql/bronze/bronze_customers.sql
3. sql/bronze/bronze_products.sql
4. sql/bronze/bronze_sellers.sql
5. sql/bronze/bronze_order_items.sql
6. sql/bronze/bronze_payments.sql
7. sql/bronze/bronze_reviews.sql

8. sql/silver/silver_orders_enriched.sql
9. sql/silver/silver_order_items_enriched.sql
10. sql/silver/silver_payments_enriched.sql
11. sql/silver/silver_reviews_enriched.sql

12. sql/gold/dim_cliente.sql
13. sql/gold/dim_produto.sql
14. sql/gold/dim_vendedor.sql
15. sql/gold/dim_tempo.sql

16. sql/gold/fato_pedidos.sql
17. sql/gold/fato_pagamentos.sql
18. sql/gold/fato_reviews.sql

19. sql/gold/vw_ecommerce_performance_comercial.sql
20. sql/gold/vw_ecommerce_experiencia_cliente.sql
```

---

## 9. Observação sobre sintaxe SQL

Os scripts foram escritos considerando sintaxe compatível com Snowflake/Dadosfera, utilizando funções como:

```text
TRY_TO_TIMESTAMP_NTZ
TRY_TO_NUMBER
TRY_TO_DECIMAL
DATEDIFF
CURRENT_TIMESTAMP
CREATE OR REPLACE TABLE
CREATE OR REPLACE VIEW
```

Caso o ambiente execute outro dialeto SQL, pequenos ajustes podem ser necessários.

---

## 10. Validações após execução

Após executar os scripts, validar se as tabelas foram criadas:

```sql
SELECT COUNT(*) FROM PUBLIC.BRONZE_ORDERS;
SELECT COUNT(*) FROM PUBLIC.SILVER_ORDERS_ENRICHED;
SELECT COUNT(*) FROM PUBLIC.GOLD_FATO_PEDIDOS;
SELECT COUNT(*) FROM PUBLIC.GOLD_VW_ECOMMERCE_PERFORMANCE_COMERCIAL;
```

Também é recomendado validar amostras:

```sql
SELECT * FROM PUBLIC.GOLD_VW_ECOMMERCE_PERFORMANCE_COMERCIAL LIMIT 10;
SELECT * FROM PUBLIC.GOLD_VW_ECOMMERCE_EXPERIENCIA_CLIENTE LIMIT 10;
```

---

## 11. Evidências

Após execução na Dadosfera, salvar prints em:

```text
evidencias/pipeline/
```

Sugestões:

```text
evidencias/pipeline/execucao_bronze.png
evidencias/pipeline/execucao_silver.png
evidencias/pipeline/execucao_gold.png
evidencias/pipeline/tabelas_gold_criadas.png
```

---

## 12. Conclusão

A ordem de execução garante que cada camada seja criada somente depois que suas dependências estiverem disponíveis.

Essa organização facilita a manutenção, rastreabilidade e entendimento do fluxo de transformação dos dados.