# Zepto Sales Data Analysis (SQL)

## Overview

This project analyzes a product-level dataset from Zepto, a quick-commerce grocery delivery platform. The dataset covers product categories, pricing, discounts, stock availability, and weight details. Using PostgreSQL, the project moves through data exploration, data cleaning, and business-focused analysis to answer questions around pricing strategy, inventory, and revenue.

## Dataset

The dataset (`zepto_v2.csv`) contains the following fields:

| Column | Description |
|---|---|
| sku_id | Unique identifier for each product (auto-generated primary key) |
| category | Product category |
| name | Product name |
| mrp | Maximum retail price |
| discountPercent | Discount applied to the product |
| availableQuantity | Quantity available in stock |
| discountedSellingPrice | Final selling price after discount |
| weightInGms | Product weight in grams |
| outOfStock | Stock status (boolean) |
| quantity | Order quantity |

## Tools Used

- PostgreSQL
- SQL (DDL, DML, aggregate functions, window-style grouping, CASE statements)

## Project Workflow

**1. Table Setup**
Created the `zepto` table with appropriate data types and constraints, then loaded data from the CSV file using the `COPY` command.

**2. Data Exploration**
Checked row counts, distinct product categories, in-stock vs. out-of-stock distribution, and identified products that appear under multiple SKUs.

**3. Data Cleaning**
Removed rows where the price was recorded as zero, since these represented invalid entries. Converted price fields from paise to rupees for consistency, since the raw values were stored in the smaller currency unit.

**4. Business Analysis**
Wrote queries to answer eight business questions, listed below.

## Key Business Questions Answered

1. Top 10 best value products based on discount percentage
2. Products with a high MRP that are currently out of stock
3. Estimated revenue by category
4. Products priced above 500 with a discount under 10%
5. Top 5 categories offering the highest average discount
6. Price per gram for products above 100 grams, to identify best value by weight
7. Classification of products into low, medium, and bulk weight categories
8. Total inventory weight per category

## Sample Insight

Products were segmented by weight into three tiers: low (under 1000g), medium (1000–5000g), and bulk (above 5000g). This kind of segmentation helps identify whether a category leans toward small daily-use items or bulk purchases, which has direct implications for warehousing and delivery logistics.

## How to Run

1. Create the database table using the DDL in `zepto_sql_project.sql`.
2. Load the CSV data using the `COPY` command (update the file path to match your local system).
3. Run the cleaning queries before proceeding to analysis, since the revenue and pricing calculations depend on cleaned data.
4. Run each numbered query independently to explore the corresponding business question.

## File Structure

```
├── zepto_sql_project.sql   # Full SQL script: table creation, cleaning, and analysis
└── README.md               # Project documentation
```

