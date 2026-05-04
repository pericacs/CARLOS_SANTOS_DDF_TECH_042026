-- ============================================================
-- Controle de Deduplicação - Camada Silver
-- Objetivo: Garantir unicidade nas principais entidades antes da Gold
-- ============================================================

-- ============================================================
-- 1. Clientes deduplicados
-- Regra: manter um registro por CUSTOMER_ID
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.SILVER_CUSTOMERS_DEDUP AS
WITH BASE AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY CUSTOMER_ID
            ORDER BY CUSTOMER_UNIQUE_ID
        ) AS RN
    FROM PUBLIC.BRONZE_CUSTOMERS
    WHERE CUSTOMER_ID IS NOT NULL
)
SELECT
    CUSTOMER_ID,
    CUSTOMER_UNIQUE_ID,
    CUSTOMER_ZIP_CODE_PREFIX,
    CUSTOMER_CITY,
    CUSTOMER_STATE,
    CURRENT_TIMESTAMP() AS SILVER_CREATED_AT
FROM BASE
WHERE RN = 1;


-- ============================================================
-- 2. Produtos deduplicados
-- Regra: manter um registro por PRODUCT_ID
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.SILVER_PRODUCTS_DEDUP AS
WITH BASE AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY PRODUCT_ID
            ORDER BY PRODUCT_CATEGORY_NAME
        ) AS RN
    FROM PUBLIC.BRONZE_PRODUCTS
    WHERE PRODUCT_ID IS NOT NULL
)
SELECT
    PRODUCT_ID,
    PRODUCT_CATEGORY_NAME,
    PRODUCT_NAME_LENGHT,
    PRODUCT_DESCRIPTION_LENGHT,
    PRODUCT_PHOTOS_QTY,
    PRODUCT_WEIGHT_G,
    PRODUCT_LENGTH_CM,
    PRODUCT_HEIGHT_CM,
    PRODUCT_WIDTH_CM,
    CURRENT_TIMESTAMP() AS SILVER_CREATED_AT
FROM BASE
WHERE RN = 1;


-- ============================================================
-- 3. Vendedores deduplicados
-- Regra: manter um registro por SELLER_ID
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.SILVER_SELLERS_DEDUP AS
WITH BASE AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY SELLER_ID
            ORDER BY SELLER_STATE, SELLER_CITY
        ) AS RN
    FROM PUBLIC.BRONZE_SELLERS
    WHERE SELLER_ID IS NOT NULL
)
SELECT
    SELLER_ID,
    SELLER_ZIP_CODE_PREFIX,
    SELLER_CITY,
    SELLER_STATE,
    CURRENT_TIMESTAMP() AS SILVER_CREATED_AT
FROM BASE
WHERE RN = 1;


-- ============================================================
-- 4. Pedidos deduplicados
-- Regra: manter um registro por ORDER_ID
-- Critério: priorizar o pedido com maior data de compra
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.SILVER_ORDERS_DEDUP AS
WITH BASE AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY ORDER_ID
            ORDER BY ORDER_PURCHASE_TIMESTAMP DESC
        ) AS RN
    FROM PUBLIC.BRONZE_ORDERS
    WHERE ORDER_ID IS NOT NULL
)
SELECT
    ORDER_ID,
    CUSTOMER_ID,
    ORDER_STATUS,
    ORDER_PURCHASE_TIMESTAMP,
    ORDER_APPROVED_AT,
    ORDER_DELIVERED_CARRIER_DATE,
    ORDER_DELIVERED_CUSTOMER_DATE,
    ORDER_ESTIMATED_DELIVERY_DATE,
    CURRENT_TIMESTAMP() AS SILVER_CREATED_AT
FROM BASE
WHERE RN = 1;


-- ============================================================
-- 5. Reviews deduplicados
-- Regra: manter um registro por REVIEW_ID
-- Critério: priorizar a avaliação mais recente
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.SILVER_REVIEWS_DEDUP AS
WITH BASE AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY REVIEW_ID
            ORDER BY REVIEW_ANSWER_TIMESTAMP DESC, REVIEW_CREATION_DATE DESC
        ) AS RN
    FROM PUBLIC.BRONZE_REVIEWS
    WHERE REVIEW_ID IS NOT NULL
)
SELECT
    REVIEW_ID,
    ORDER_ID,
    REVIEW_SCORE,
    REVIEW_COMMENT_TITLE,
    REVIEW_COMMENT_MESSAGE,
    REVIEW_CREATION_DATE,
    REVIEW_ANSWER_TIMESTAMP,
    CURRENT_TIMESTAMP() AS SILVER_CREATED_AT
FROM BASE
WHERE RN = 1;


-- ============================================================
-- 6. Itens deduplicados
-- Regra: manter um registro por ORDER_ID + ORDER_ITEM_ID
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.SILVER_ORDER_ITEMS_DEDUP AS
WITH BASE AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY ORDER_ID, ORDER_ITEM_ID
            ORDER BY SHIPPING_LIMIT_DATE DESC
        ) AS RN
    FROM PUBLIC.BRONZE_ORDER_ITEMS
    WHERE ORDER_ID IS NOT NULL
      AND ORDER_ITEM_ID IS NOT NULL
)
SELECT
    ORDER_ID,
    ORDER_ITEM_ID,
    PRODUCT_ID,
    SELLER_ID,
    SHIPPING_LIMIT_DATE,
    PRICE,
    FREIGHT_VALUE,
    CURRENT_TIMESTAMP() AS SILVER_CREATED_AT
FROM BASE
WHERE RN = 1;


-- ============================================================
-- 7. Pagamentos deduplicados
-- Regra: manter um registro por ORDER_ID + PAYMENT_SEQUENTIAL
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.SILVER_PAYMENTS_DEDUP AS
WITH BASE AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY ORDER_ID, PAYMENT_SEQUENTIAL
            ORDER BY PAYMENT_VALUE DESC
        ) AS RN
    FROM PUBLIC.BRONZE_PAYMENTS
    WHERE ORDER_ID IS NOT NULL
      AND PAYMENT_SEQUENTIAL IS NOT NULL
)
SELECT
    ORDER_ID,
    PAYMENT_SEQUENTIAL,
    PAYMENT_TYPE,
    PAYMENT_INSTALLMENTS,
    PAYMENT_VALUE,
    CURRENT_TIMESTAMP() AS SILVER_CREATED_AT
FROM BASE
WHERE RN = 1;