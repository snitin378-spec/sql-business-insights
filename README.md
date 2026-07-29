# SQL Business Insights Portfolio

## E-Commerce Business Analytics using PostgreSQL & Metabase

This repository demonstrates how SQL can be used to solve real-world business problems by analysing an e-commerce dataset. The project consists of **10 business-focused SQL analyses** covering sales performance, customer retention, marketing attribution, payment analytics, logistics performance, customer lifetime value, and operational KPIs.

---

# 🔗 Portfolio Links

📄 Notion Case Study:https://even-spur-9ce.notion.site/What-10-SQL-Queries-Told-Me-About-This-Business-3abd27da0337806dba92d58be28394f5

📊 Metabase Collection:https://metabase.topfolio.in/collection/99-task-1-sql-foundation

💻 GitHub Repository:https://github.com/snitin378-spec/sql-business-insights

---

# 📈 Executive Summary

This project analyses an e-commerce dataset containing **40,000 customer orders** using PostgreSQL and Metabase. Through ten production-style SQL analyses, the project transforms raw transactional data into actionable business insights across sales, marketing, customer behaviour, operations, and logistics.

## Business Highlights

| Business Metric | Result |
|-----------------|-------:|
| **Total Revenue Analyzed** | **253,047,045** |
| **Total Orders Analyzed** | **40,000** |
| **Total Customers Analyzed** | **8,800** |
| **Average Order Value (AOV)** | **6,326.18** |
| **Top Performing Acquisition Channel** | **Organic (94,782,169 revenue • 40% revenue share)** |
| **Month-1 Retention Rate** | **50% (March 2026 Cohort)** |
| **Highest LTV Revenue Segment** | **₹20,000+ customers contributed 86% of total revenue** |
| **Best Delivery SLA Performance** | **Delivery Standard – 3.16 average delivery days with a 3.1% late delivery rate** |
| **Payment Method with Highest Failure Rate** | **UPI – 5.5% failure rate (Gateway Timeout)** |

---

# ⭐ Headline Findings

- Analyzed **40,000 orders** generating **253,047,045** in revenue across **8,800 customers**.
- Maintained an **Average Order Value (AOV) of 6,326.18**, demonstrating consistent customer spending.
- **Organic acquisition** generated **94,782,169** in revenue, contributing **40%** of total attributed revenue and making it the highest-performing acquisition channel.
- The **March 2026 customer cohort achieved a 50% Month-1 retention rate**, decreasing to **42% in Month 2** and **19% in Month 3**, highlighting opportunities to improve long-term customer retention.
- Customers in the **₹20,000+ Lifetime Value segment contributed 86% of total revenue**, showing that a relatively small group of high-value customers drives most business value.
- **Delivery Standard** achieved the strongest logistics performance with an **average delivery time of 3.16 days** and only a **3.1% late delivery rate**.
- **UPI** recorded the highest payment failure rate (**5.5%**), with **Gateway Timeout** identified as the most common failure reason.

---

# 📊 Business Questions & SQL Analyses

| Query | Stakeholder Question | Key Data Insight |
|------|-----------------------|------------------|
| **Q1 – Daily Business Summary** | How is daily business performance changing over time? | Analyzed daily revenue, orders, AOV, refunds and revenue trends using day-over-day and week-over-week comparisons. |
| **Q2 – Monthly Cohort Retention** | Are newly acquired customers returning after their first purchase? | Measured Month-1, Month-2 and Month-3 retention rates to identify customer drop-off over time. |
| **Q3 – Funnel Conversion Analysis** | Where do customers abandon the purchase journey? | Identified the largest conversion drop-off across product view, cart, checkout and purchase stages. |
| **Q4 – Top Products by Net Revenue** | Which products generate the highest business value? | Ranked products based on net revenue after accounting for refunds. |
| **Q5 – Category Health** | Which product categories perform best? | Compared category revenue, refund rates and sales performance. |
| **Q6 – Payment Failure Analysis** | Which payment methods have the highest failure rates? | Identified UPI as the highest failure-rate payment method, with Gateway Timeout as the leading failure reason. |
| **Q7 – Delivery SLA Analysis** | Are deliveries meeting operational SLA targets? | Compared carriers and shipping methods to identify the best delivery performance and late-delivery rates. |
| **Q8 – Customer Lifetime Value (LTV)** | Which customers contribute the most revenue? | Segmented customers into LTV buckets and found that the ₹20,000+ segment contributes 86% of total revenue. |
| **Q9 – Repeat Purchase Interval** | How frequently do customers make repeat purchases? | Calculated repeat purchase intervals to understand customer purchasing behavior. |
| **Q10 – Marketing Attribution** | Which marketing channels generate the most revenue? | Compared first-touch and last-touch attribution, identifying Organic as the highest-performing acquisition channel. |

---

# 📊 Dashboard Snapshots

## Daily Business Summary

![Daily Business Summary](images/daily_business_summary.png)

---

## Funnel Conversion Analysis

![Funnel Conversion](images/funnel_conversion.png)

---

## Customer Lifetime Value (LTV)

![Customer LTV](images/customer_ltv.png)

---

# 🛠 Technologies Used

- PostgreSQL
- SQL
- Metabase
- GitHub
- Notion

---

# SQL Concepts Demonstrated

- Common Table Expressions (CTEs)
- Window Functions
- ROW_NUMBER()
- LEAD()
- LAG()
- CASE Expressions
- Aggregate Functions
- FILTER Clause
- Joins
- Cohort Analysis
- Funnel Analysis
- Marketing Attribution
- Customer Segmentation
- Percentile Analysis

---

# Repository Structure

```text
sql-business-insights/
│
├── README.md
├── INTERPRETATIONS.md
├── case_study_link.md
│
├── notes/
│     └── ecom_schema.md
│
├── images/
│     ├── daily_business_summary.png
│     ├── funnel_conversion.png
│     └── customer_ltv.png
│
└── queries/
      ├── 01_daily_business_summary.sql
      ├── 02_monthly_cohort_retention.sql
      ├── 03_funnel_conversion.sql
      ├── 04_top_products_by_net_revenue.sql
      ├── 05_category_health.sql
      ├── 06_payment_failure_analysis.sql
      ├── 07_delivery_sla.sql
      ├── 08_customer_ltv.sql
      ├── 09_repeat_purchase_interval.sql
      └── 10_marketing_attribution.sql
```

---

# Key Skills Demonstrated

- SQL Development
- PostgreSQL
- Business Analytics
- Customer Analytics
- Marketing Analytics
- Product Analytics
- Operational Reporting
- Data Modelling
- Business Intelligence
- KPI Reporting
- Data Storytelling

---

# Project Outcome

This project demonstrates the ability to translate business questions into production-quality SQL analyses, validate results through structured sanity checks, and communicate insights through executive-level documentation and dashboards. The combination of SQL, Metabase visualisations, GitHub documentation, and a detailed Notion case study showcases an end-to-end analytics workflow suitable for business and product analytics roles.
