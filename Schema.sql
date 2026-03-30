create database marketing;
use marketing;

CREATE TABLE fact_campaigns (
    campaign_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    brand VARCHAR(100),
    campaign_name VARCHAR(255),
    ad_group_name VARCHAR(255),
    platform VARCHAR(50), -- e.g., FB, Google
    spend FLOAT DEFAULT 0,
    impressions INT DEFAULT 0,
    clicks INT DEFAULT 0,
    conversions INT DEFAULT 0
);

select * from fact_campaigns;

CREATE TABLE fact_shopify_sales (
    order_id VARCHAR(100) PRIMARY KEY, -- Stored as string to prevent scientific notation
    date DATE NOT NULL,
    sales_channel VARCHAR(100),
    gross_sales_inr FLOAT DEFAULT 0,
    discounts_inr FLOAT DEFAULT 0,
    returns_inr FLOAT DEFAULT 0,
    net_sales_inr FLOAT DEFAULT 0,
    items_sold INT DEFAULT 0,
    customer_type VARCHAR(50), -- New vs Returning
    billing_city VARCHAR(100),
    shipping_country VARCHAR(100)
);
CREATE VIEW view_marketing_performance AS
SELECT 
    c.date,
    c.brand,
    SUM(c.spend) AS total_spend,
    SUM(c.clicks) AS total_clicks,
    COALESCE(SUM(s.net_sales_inr), 0) AS total_net_sales,
    -- Calculate ROAS (Return on Ad Spend)
    CASE 
        WHEN SUM(c.spend) > 0 THEN SUM(s.net_sales_inr) / SUM(c.spend) 
        ELSE 0 
    END AS roas
FROM fact_campaigns c
LEFT JOIN fact_shopify_sales s ON c.date = s.date
GROUP BY c.date, c.brand;
