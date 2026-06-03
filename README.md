# EuroLens | European Real Estate Market Intelligence
 
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
 
> A market intelligence dashboard simulating the work of a Data Analyst at a European property intelligence platform — analyzing 5,000 listings across 10 countries to surface pricing dynamics, market activity, investment potential, and location competitiveness.
 
---
 
## Project Background
 
EuroLens is a fictional European property intelligence platform. This project simulates a real-world analyst deliverable — an internal market intelligence report built for an investment committee needing data-driven answers about the European property market.
 
The dataset contains 5,000 property listings spanning 2020 to 2024 across 10 European countries and 10 cities, covering property characteristics, pricing, amenities, energy efficiency, and listing activity.
 
This project was built as part of the FP20 Analytics Challenge 36.
 
---
 
## Business Questions Answered
 
- How do property prices and price per square meter vary across countries and cities?
- Which property types command the highest prices?
- Do premium amenities (gym, pool, elevator) actually drive up property prices?
- Which markets have the highest rental yield for investors?
- Where are properties sitting longest on the market and why?
- Does high price always mean high investment return?
- Which cities and countries present the strongest investment opportunities?
---
 
## Key Findings
 
**Pricing Dynamics**
- France commands the highest average price per SQM at €5.2K, Poland the lowest at €1.5K — a 3.5x gap across the continent
- Mixed-Use and Office properties carry the highest price per SQM across all markets
- Elevator access shows a consistent price premium in Western European markets; gym and pool show minimal impact on pricing
**Market Activity**
- The European property market is slow-paced — even the fastest moving properties average 138 days on market
- Listing activity peaks in January and dips sharply in February across all markets
- Retail properties sit longest on the market at an average of 178 days
**Investment Potential**
- All 10 countries deliver annual rental yields between 5.45% and 7.20% — all above the 6% investment threshold
- Austria leads all countries in yield at 7.20% despite not being the most expensive market
- France ranks last in yield at 5.45% — the most expensive market to enter but the weakest on returns
- High price does not equal high yield: the correlation between price per SQM and annual yield is negative
- Properties have appreciated an average of 50.52% since their last recorded sale price
**Location Competitiveness**
- Paris Mixed-Use Rental listings deliver the highest city-level yield at 8.27%
- Vienna and Berlin consistently appear in top yield positions across property types
- Amsterdam and Paris are the most expensive cities but among the slowest moving markets
---
 
## Dashboard Structure
 
The report is structured across three pages:
 
**Page 1 — European Real Estate Market Intelligence**
High-level overview including total listings, average price per SQM, average days on market, average annual yield, listing type split, geographic distribution map, and country-level price comparison.
 
**Page 2 — Market Deep Dive**
Pricing dynamics and market activity including monthly listing trends, price per SQM by property type, amenity impact on pricing, days on market by property type and country, and key market KPIs.
 
**Page 3 — Investment Intelligence**
Rental yield analysis including scatter plot of price vs yield by city, top and bottom yield performers by city and country, and a detailed investment breakdown matrix by country, city, property type, and listing type.
 
---
 
## Technical Approach
 
**Data Source**
5,000 property listings loaded from SQL Server into Power BI via the SQL Server connector using Import mode.
 
**SQL Analysis (EDA and Insight Discovery)**
Before building any visuals, the dataset was explored in SQL Server to validate data quality, understand distributions, and identify insight angles across all four analytical areas. Key SQL work included:
- Null analysis and structural data quality assessment
- Market activity analysis by country, property type, and listing month
- Pricing dynamics by country, city, property type, and amenity
- Rental yield calculation using monthly rent and last sold price
- Location competitiveness scoring combining price, days on market, and listing volume
**Power Query Transformations**
- Data type corrections for floor_number and year_built
- Location table created via column selection, deduplication, and index key
- Date table created with Year, Month Name, and Month Number columns
- Amenity impact table created by selecting price_per_sqm and amenity columns, then unpivoting gym, swimming_pool, and elevator for comparative analysis
- Dedicated measures table created using Enter Data
**Data Model**
Star schema with one-to-many relationships between the main fact table and the location and date dimension tables.
 
**DAX Measures (13 total)**
- Total Listings, Sales Listings, Rental Listings
- Avg Price per SQM, Avg Sale Price, Avg Monthly Rent, Avg Annual Rent
- Avg Days on Market
- Avg Annual Yield
- Price Appreciation %
- Property Age
- Premium Amenities Count
---
 
## Tools Used
 
- SQL Server — EDA, data quality checks, insight discovery
- Power BI Desktop — data modeling, DAX, dashboard design
- Power Query — data transformation and normalization
---
 
## Project Structure
 
```
eurolens/
├── dataset.xlsx
├── sql
├── documentation.docx
├── eurolens.pbix
└── README.md

```
 
---
 
## Dashboard Preview
 
**Page 1 — Overview**
<img width="1404" height="805" alt="Screenshot 2026-06-03 144245" src="https://github.com/user-attachments/assets/4eb79c36-32e4-47cb-81d4-265c6a02cf8b" />

 
**Page 2 — Market Deep Dive**
<img width="704" height="403" alt="Screenshot 2026-06-03 151022" src="https://github.com/user-attachments/assets/6b985a5a-185f-4121-bcea-000ff6293997" />

 
**Page 3 — Investment Intelligence**
<img width="703" height="403" alt="Screenshot 2026-06-03 151349" src="https://github.com/user-attachments/assets/a9aa40fb-3037-4f0e-8a7e-79a433b7970b" />

 
---
 
## Author
 
**Mustapha Ambali**
Data Analyst | Business Performance and Commercial Analytics
 
[LinkedIn](https://www.linkedin.com/in/mustapha-ambali) | [GitHub](https://github.com/MustaphaAMBALI) | [Portfolio](https://mustaphaambali.github.io)
 
