-- ============================================================
-- Tabela: PUBLIC.BRONZE_SELLERS
-- Camada: Bronze
-- Origem: PUBLIC.RAW_SELLERS
-- Objetivo: Padronizar dados cadastrais e geográficos dos vendedores
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.BRONZE_SELLERS AS
SELECT
    SELLER_ID::VARCHAR AS SELLER_ID,
    TRY_TO_NUMBER(SELLER_ZIP_CODE_PREFIX) AS SELLER_ZIP_CODE_PREFIX,
    LOWER(TRIM(SELLER_CITY)) AS SELLER_CITY,
    UPPER(TRIM(SELLER_STATE)) AS SELLER_STATE,

    CURRENT_TIMESTAMP() AS BRONZE_CREATED_AT
FROM PUBLIC.RAW_SELLERS;