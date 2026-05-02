-- ============================================================
-- Tabela: PUBLIC.BRONZE_SELLERS
-- Camada: Bronze
-- Origem: PUBLIC.TB__JIZIE8__PUBLIC__TB_SELLERS
-- Objetivo: Padronizar dados cadastrais e geográficos dos vendedores
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.BRONZE_SELLERS AS
SELECT
    SELLER_ID::VARCHAR AS SELLER_ID,
    CAST(SELLER_ZIP_CODE_PREFIX AS NUMBER) AS SELLER_ZIP_CODE_PREFIX,
    LOWER(TRIM(SELLER_CITY::VARCHAR)) AS SELLER_CITY,
    UPPER(TRIM(SELLER_STATE::VARCHAR)) AS SELLER_STATE,

    CURRENT_TIMESTAMP() AS BRONZE_CREATED_AT
FROM PUBLIC.TB__JIZIE8__PUBLIC__TB_SELLERS;