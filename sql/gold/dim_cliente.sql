-- ============================================================
-- Tabela: dim_cliente
-- Camada: Gold
-- Objetivo: Dimensão de clientes para análise geográfica e recorrência
-- Origem: customers
-- ============================================================

CREATE OR REPLACE TABLE gold.dim_cliente AS
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS sk_cliente,
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM silver.customers
WHERE customer_id IS NOT NULL;