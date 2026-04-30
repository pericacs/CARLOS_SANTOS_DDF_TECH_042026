-- ============================================================
-- Tabela: dim_tempo
-- Camada: Gold
-- Objetivo: Dimensão calendário para análises temporais
-- Origem: orders
-- ============================================================

CREATE OR REPLACE TABLE gold.dim_tempo AS
WITH datas AS (
    SELECT DISTINCT
        CAST(order_purchase_timestamp AS DATE) AS data
    FROM silver.orders
    WHERE order_purchase_timestamp IS NOT NULL

    UNION

    SELECT DISTINCT
        CAST(order_approved_at AS DATE) AS data
    FROM silver.orders
    WHERE order_approved_at IS NOT NULL

    UNION

    SELECT DISTINCT
        CAST(order_delivered_customer_date AS DATE) AS data
    FROM silver.orders
    WHERE order_delivered_customer_date IS NOT NULL

    UNION

    SELECT DISTINCT
        CAST(order_estimated_delivery_date AS DATE) AS data
    FROM silver.orders
    WHERE order_estimated_delivery_date IS NOT NULL
)

SELECT
    CAST(REPLACE(CAST(data AS VARCHAR), '-', '') AS INTEGER) AS sk_tempo,
    data,
    EXTRACT(YEAR FROM data) AS ano,
    EXTRACT(MONTH FROM data) AS mes,
    EXTRACT(DAY FROM data) AS dia,
    EXTRACT(QUARTER FROM data) AS trimestre,
    EXTRACT(DOW FROM data) AS dia_semana
FROM datas
WHERE data IS NOT NULL;