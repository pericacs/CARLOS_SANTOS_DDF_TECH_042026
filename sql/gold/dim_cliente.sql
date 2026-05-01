-- ============================================================
-- Tabela: PUBLIC.GOLD_DIM_CLIENTE
-- Camada: Gold
-- Objetivo: Dimensão de clientes para análise geográfica e recorrência
-- Origem: PUBLIC.SILVER_ORDERS_ENRICHED
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.GOLD_DIM_CLIENTE AS
SELECT
    ROW_NUMBER() OVER (ORDER BY CUSTOMER_ID) AS SK_CLIENTE,
    CUSTOMER_ID,
    CUSTOMER_UNIQUE_ID,
    CUSTOMER_ZIP_CODE_PREFIX,
    CUSTOMER_CITY,
    CUSTOMER_STATE,
    CURRENT_TIMESTAMP() AS GOLD_CREATED_AT
FROM (
    SELECT DISTINCT
        CUSTOMER_ID,
        CUSTOMER_UNIQUE_ID,
        CUSTOMER_ZIP_CODE_PREFIX,
        CUSTOMER_CITY,
        CUSTOMER_STATE
    FROM PUBLIC.SILVER_ORDERS_ENRICHED
    WHERE CUSTOMER_ID IS NOT NULL
);