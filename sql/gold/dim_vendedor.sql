-- ============================================================
-- Tabela: dim_vendedor
-- Camada: Gold
-- Objetivo: Dimensão de vendedores para análise comercial e logística
-- Origem: sellers
-- ============================================================

CREATE OR REPLACE TABLE gold.dim_vendedor AS
SELECT
    ROW_NUMBER() OVER (ORDER BY seller_id) AS sk_vendedor,
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM silver.sellers
WHERE seller_id IS NOT NULL;