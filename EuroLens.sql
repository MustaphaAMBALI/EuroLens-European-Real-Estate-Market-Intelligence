-- Total row count 
SELECT COUNT(*) AS total_rows
FROM real_estate


-- Checking for NULLS
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN sale_price_eur IS NULL THEN 1 ELSE 0 END) AS null_sale_price,
    SUM(CASE WHEN monthly_rent_eur IS NULL THEN 1 ELSE 0 END) AS null_rent,
    SUM(CASE WHEN price_per_sqm IS NULL THEN 1 ELSE 0 END) AS null_price_per_sqm,
    SUM(CASE WHEN square_meters IS NULL THEN 1 ELSE 0 END) AS null_sqm,
    SUM(CASE WHEN days_on_market IS NULL THEN 1 ELSE 0 END) AS null_days,
    SUM(CASE WHEN energy_rating IS NULL THEN 1 ELSE 0 END) AS null_energy,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS null_country
FROM real_estate;



-- Confirm the listing_type split
SELECT listing_type, COUNT(*) AS total
FROM real_estate
GROUP BY listing_type;



-- Check if nulls in price_per_sqm and square_meters are concentrated in one listing type or spread across both
SELECT 
    listing_type,
    SUM(CASE WHEN square_meters IS NULL THEN 1 ELSE 0 END) AS null_sqm,
    SUM(CASE WHEN price_per_sqm IS NULL THEN 1 ELSE 0 END) AS null_price_per_sqm,
    SUM(CASE WHEN days_on_market IS NULL THEN 1 ELSE 0 END) AS null_days
FROM real_estate
GROUP BY listing_type;


--- Exploratory Analysis EDA
-- =============================================
-- MARKET ACTIVITY ANALYSIS
-- Purpose: Understand listing volume and average
-- days on market by country, property type and month
-- =============================================

WITH listing_dates AS (
    SELECT
        property_id,
        property_type,
        country,
        days_on_market,
        FORMAT(listing_date, 'MMM-yy') AS listing_month,
        YEAR(listing_date)              AS listing_year,
        MONTH(listing_date)             AS listing_month_num
    FROM real_estate
)

SELECT
    listing_month,
    property_type,
    country,
    COUNT(property_id)      AS total_listings,
    AVG(days_on_market)     AS avg_days_on_market
FROM listing_dates
GROUP BY listing_month, listing_year, listing_month_num, property_type, country
ORDER BY listing_year, listing_month_num


-- Query 2
SELECT
    property_type,
    country,
    COUNT(property_id) total_listings,
    AVG(days_on_market) days_on_the_market
FROM real_estate
GROUP BY property_type,country;


-- =============================================
-- PRICING DYNAMICS ANALYSIS
-- Purpose: Understand how property prices vary
-- across locations, property types and amenities
-- =============================================

-- 1. Average price per sqm by country
SELECT
    country,
    ROUND(AVG(price_per_sqm), 2) AS avg_price_per_sqm
FROM real_estate
GROUP BY country
ORDER BY avg_price_per_sqm DESC;

-- 2. Average price per sqm by country, city and property type
SELECT
    country,
    city,
    property_type,
    ROUND(AVG(price_per_sqm), 2) AS avg_price_per_sqm
FROM real_estate
GROUP BY country, city, property_type
ORDER BY avg_price_per_sqm DESC;

-- 3. Impact of amenities on price per sqm
SELECT
    country,
    gym,
    swimming_pool,
    elevator,
    ROUND(AVG(price_per_sqm), 2) AS avg_price_per_sqm
FROM real_estate
GROUP BY country, gym, swimming_pool, elevator
ORDER BY country, avg_price_per_sqm DESC;


-- =============================================
-- INVESTMENT POTENTIAL ANALYSIS
-- Purpose: Identify rental yield opportunities
-- across countries, cities and property types
-- Note: Yield calculated using last_sold_price_eur
-- as sale_price_eur and monthly_rent_eur are mutually
-- exclusive in this dataset (1,815 overlapping records)
-- Formula: (monthly_rent_eur * 12) / last_sold_price_eur * 100
-- =============================================

-- 1. Rental yield by country
SELECT
    country,
    ROUND(
        AVG((monthly_rent_eur * 12) / last_sold_price_eur * 100), 2) AS annual_yield_pct
FROM real_estate
WHERE monthly_rent_eur IS NOT NULL
    AND last_sold_price_eur IS NOT NULL
GROUP BY country
ORDER BY annual_yield_pct DESC;

-- 2. Rental yield by country, city and property type
SELECT
    COUNT(property_id)              AS total_properties,
    country,
    city,
    property_type,
    ROUND(
        AVG((monthly_rent_eur * 12) / last_sold_price_eur * 100), 2) AS annual_yield_pct
FROM real_estate
WHERE monthly_rent_eur IS NOT NULL
    AND last_sold_price_eur IS NOT NULL
GROUP BY country, city, property_type
ORDER BY annual_yield_pct DESC;


-- =============================================
-- LOCATION COMPETITIVENESS ANALYSIS
-- Purpose: Identify the most and least competitive
-- markets by combining price, demand velocity,
-- and listing volume across cities and countries
-- =============================================

-- 1. Country level competitiveness
SELECT
    COUNT(property_id)              AS total_listings,
    country,
    ROUND(AVG(days_on_market), 2)   AS avg_days_on_market,
    ROUND(AVG(price_per_sqm), 2)    AS avg_price_per_sqm
FROM real_estate
GROUP BY country
ORDER BY avg_days_on_market ASC;

-- 2. City level competitiveness by listing type
SELECT
    COUNT(property_id)              AS total_listings,
    country,
    city,
    listing_type,
    ROUND(AVG(days_on_market), 2)   AS avg_days_on_market,
    ROUND(AVG(price_per_sqm), 2)    AS avg_price_per_sqm
FROM real_estate
GROUP BY country, city, listing_type
ORDER BY avg_days_on_market ASC;