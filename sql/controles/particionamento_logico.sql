-- ============================================================
-- Particionamento Lógico / Organização Analítica
-- Objetivo: Criar colunas de particionamento lógico para performance
-- ============================================================

-- ============================================================
-- 1. Pedidos com particionamento lógico por data de compra
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.SILVER_ORDERS_PARTITIONED AS
SELECT
    *,
    YEAR(ORDER_PURCHASE_DATE) AS PARTITION_YEAR,
    MONTH(ORDER_PURCHASE_DATE) AS PARTITION_MONTH,
    TO_CHAR(ORDER_PURCHASE_DATE, 'YYYY-MM') AS PARTITION_YEAR_MONTH
FROM PUBLIC.SILVER_ORDERS_ENRICHED;


-- ============================================================
-- 2. Itens com particionamento lógico por categoria e vendedor
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.SILVER_ORDER_ITEMS_PARTITIONED AS
SELECT
    *,
    COALESCE(PRODUCT_CATEGORY_NAME_ENGLISH, PRODUCT_CATEGORY_NAME, 'sem_categoria') AS PARTITION_CATEGORY,
    SELLER_STATE AS PARTITION_SELLER_STATE
FROM PUBLIC.SILVER_ORDER_ITEMS_ENRICHED;


-- ============================================================
-- 3. Reviews com particionamento lógico por data e classificação
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.SILVER_REVIEWS_PARTITIONED AS
SELECT
    *,
    YEAR(REVIEW_CREATION_DATE_ONLY) AS PARTITION_YEAR,
    MONTH(REVIEW_CREATION_DATE_ONLY) AS PARTITION_MONTH,
    TO_CHAR(REVIEW_CREATION_DATE_ONLY, 'YYYY-MM') AS PARTITION_YEAR_MONTH,
    REVIEW_CLASSIFICATION AS PARTITION_REVIEW_CLASSIFICATION
FROM PUBLIC.SILVER_REVIEWS_ENRICHED;


-- ============================================================
-- 4. View de auditoria de particionamento lógico
-- ============================================================

CREATE OR REPLACE VIEW PUBLIC.VW_PARTITION_AUDIT AS
SELECT
    'SILVER_ORDERS_PARTITIONED' AS TABELA,
    PARTITION_YEAR_MONTH AS PARTICAO,
    COUNT(*) AS TOTAL_REGISTROS
FROM PUBLIC.SILVER_ORDERS_PARTITIONED
GROUP BY PARTITION_YEAR_MONTH

UNION ALL

SELECT
    'SILVER_REVIEWS_PARTITIONED' AS TABELA,
    PARTITION_YEAR_MONTH AS PARTICAO,
    COUNT(*) AS TOTAL_REGISTROS
FROM PUBLIC.SILVER_REVIEWS_PARTITIONED
GROUP BY PARTITION_YEAR_MONTH;