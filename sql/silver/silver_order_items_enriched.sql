-- ============================================================
-- Tabela: PUBLIC.SILVER_ORDER_ITEMS_ENRICHED
-- Camada: Silver
-- Origem: PUBLIC.BRONZE_ORDER_ITEMS + PRODUCTS + SELLERS
-- Objetivo: Enriquecer itens de pedido com produto, categoria e vendedor
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.SILVER_ORDER_ITEMS_ENRICHED AS
SELECT
    oi.ORDER_ID,
    oi.ORDER_ITEM_ID,
    oi.PRODUCT_ID,
    oi.SELLER_ID,

    p.PRODUCT_CATEGORY_NAME,

    p.PRODUCT_NAME_LENGHT,
    p.PRODUCT_DESCRIPTION_LENGHT,
    p.PRODUCT_PHOTOS_QTY,
    p.PRODUCT_WEIGHT_G,
    p.PRODUCT_LENGTH_CM,
    p.PRODUCT_HEIGHT_CM,
    p.PRODUCT_WIDTH_CM,

    s.SELLER_CITY,
    s.SELLER_STATE,
    s.SELLER_ZIP_CODE_PREFIX,

    oi.SHIPPING_LIMIT_DATE,

    oi.PRICE,
    oi.FREIGHT_VALUE,

    oi.PRICE + oi.FREIGHT_VALUE AS ITEM_TOTAL_VALUE,

    CASE
        WHEN oi.PRICE IS NULL THEN 'price_missing'
        WHEN oi.PRICE = 0 THEN 'free_or_zero_price'
        WHEN oi.PRICE > 0 THEN 'valid_price'
        ELSE 'invalid_price'
    END AS PRICE_STATUS,

    CASE
        WHEN oi.FREIGHT_VALUE IS NULL THEN 'freight_missing'
        WHEN oi.FREIGHT_VALUE = 0 THEN 'free_freight'
        WHEN oi.FREIGHT_VALUE > 0 THEN 'paid_freight'
        ELSE 'invalid_freight'
    END AS FREIGHT_STATUS,

    CURRENT_TIMESTAMP() AS SILVER_CREATED_AT

FROM PUBLIC.BRONZE_ORDER_ITEMS oi

LEFT JOIN PUBLIC.BRONZE_PRODUCTS p
    ON oi.PRODUCT_ID = p.PRODUCT_ID

LEFT JOIN PUBLIC.BRONZE_SELLERS s
    ON oi.SELLER_ID = s.SELLER_ID;