-- ============================================================
-- Tabela: PUBLIC.GOLD_DIM_VENDEDOR
-- Camada: Gold
-- Objetivo: Dimensão de vendedores para análise comercial e logística
-- Origem: PUBLIC.SILVER_ORDER_ITEMS_ENRICHED
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.GOLD_DIM_VENDEDOR AS
SELECT
    ROW_NUMBER() OVER (ORDER BY SELLER_ID) AS SK_VENDEDOR,
    SELLER_ID,
    SELLER_ZIP_CODE_PREFIX,
    SELLER_CITY,
    SELLER_STATE,
    CURRENT_TIMESTAMP() AS GOLD_CREATED_AT
FROM (
    SELECT DISTINCT
        SELLER_ID,
        SELLER_ZIP_CODE_PREFIX,
        SELLER_CITY,
        SELLER_STATE
    FROM PUBLIC.SILVER_ORDER_ITEMS_ENRICHED
    WHERE SELLER_ID IS NOT NULL
);