# SQL Business Insights

## Project Overview

This project demonstrates SQL-based business analysis on an Ecommerce database using PostgreSQL. The objective was to answer real-world business questions by writing production-style SQL queries, validating the results, and interpreting business insights.

The project was completed as part of the SQL Foundation assignment.

---

## Database

- Database: PostgreSQL
- Schema: `ecom`
- Query Tool: Metabase

---

## Business Questions Solved

| Query | Business Question |
|--------|-------------------|
| Q1 | Daily Business Summary |
| Q2 | Monthly Cohort Retention |
| Q3 | Funnel Conversion by Acquisition Channel |
| Q4 | Top Products by Net Revenue |
| Q5 | Category Health |
| Q6 | Payment Failure Analysis |
| Q7 | Delivery SLA Breach |
| Q8 | Customer Lifetime Value (LTV) |
| Q9 | Repeat Purchase Interval |
| Q10 | First Touch vs Last Touch Attribution |

---

## SQL Concepts Demonstrated

- SELECT
- GROUP BY
- ORDER BY
- INNER JOIN
- LEFT JOIN
- CASE
- COALESCE
- Aggregate Functions
- CTEs
- Window Functions
  - ROW_NUMBER()
  - LAG()
  - LEAD()
  - PERCENTILE_CONT()
- FILTER()
- DATE_TRUNC()

---

## Repository Structure

```
sql-business-insights/

├── README.md
├── INTERPRETATIONS.md
├── notes/
│     └── ecom_schema.md
│
├── queries/
│     ├── 01_daily_business_summary.sql
│     ├── 02_monthly_cohort_retention.sql
│     ├── 03_funnel_conversion_by_acquisition_channel.sql
│     ├── 04_top_products_by_net_revenue.sql
│     ├── 05_category_health.sql
│     ├── 06_payment_failure_analysis.sql
│     ├── 07_delivery_sla_breach.sql
│     ├── 08_customer_ltv.sql
│     ├── 09_repeat_purchase_interval.sql
│     └── 10_attribution_first_vs_last.sql
```

---

## Tools Used

- PostgreSQL
- Metabase
- GitHub
- DBeaver

---

## Learning Outcomes

Through this project I learned how to:

- Understand a new database schema.
- Build business-focused SQL queries.
- Use production SQL formatting.
- Apply window functions for business analysis.
- Validate SQL results using sanity checks.
- Translate SQL output into business insights.

---
