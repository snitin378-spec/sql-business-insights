# SQL Business Insights – Query Interpretations

This document explains the purpose, SQL approach, business insights, and possible follow-up questions for each SQL analysis.

---

# Q1 – Daily Business Summary

## What the query does

Summarises daily business performance by calculating revenue, total orders, average order value (AOV), paid order rate, cancelled order rate, refund amount, and compares revenue with the previous day and the same weekday from the previous week.

## Pattern Choice

Uses Common Table Expressions (CTEs), LEFT JOIN, COALESCE(), LAG() window function, GROUP BY, and aggregate functions.

## Business Interpretation

This report provides management with a daily snapshot of business performance. Comparing today's revenue with yesterday and the previous week's same weekday helps identify trends while reducing weekday seasonality.

## What I'd Ask Next

Which products or marketing campaigns contributed most to revenue increases or decreases?

---

# Q2 – Monthly Cohort Retention

## What the query does

Groups customers into monthly signup cohorts and measures how many customers return in Month 1, Month 2, and Month 3.

## Pattern Choice

Uses multiple CTEs, DATE_TRUNC(), LEFT JOIN, conditional aggregation, and retention rate calculations.

## Business Interpretation

Customer retention decreases over time. This report helps identify which signup cohorts remain active and which require targeted retention campaigns.

## What I'd Ask Next

Which acquisition channels produce customers with the highest long-term retention?

---

# Q3 – Funnel Conversion by Acquisition Channel

## What the query does

Measures customer movement through the purchase funnel from Product View to Add to Cart, Checkout, and Purchase for each acquisition channel.

## Pattern Choice

Uses COUNT(DISTINCT), FILTER(), LEFT JOIN, COALESCE(), and GROUP BY.

## Business Interpretation

This identifies where customers drop out of the purchase journey and which marketing channels have the strongest conversion rates.

## What I'd Ask Next

Which stage of the checkout process causes the highest abandonment?

---

# Q4 – Top Products by Net Revenue

## What the query does

Calculates gross revenue, refund amount, and net revenue for every product.

## Pattern Choice

Uses multiple CTEs, JOINs, GROUP BY, SUM(), COUNT(), and COALESCE().

## Business Interpretation

This identifies products that generate the highest profit after accounting for customer refunds.

## What I'd Ask Next

Why do some high-selling products also receive high refund amounts?

---

# Q5 – Category Health

## What the query does

Summarises revenue, orders, units sold, refunds, and refund rate for every product category.

## Pattern Choice

Uses multiple CTEs, GROUP BY, LEFT JOIN, aggregate functions, and COALESCE().

## Business Interpretation

The report highlights categories that generate strong revenue while maintaining low refund rates, helping category managers identify healthy product segments.

## What I'd Ask Next

Which categories have increasing refund rates over time?

---

# Q6 – Payment Failure Analysis

## What the query does

Calculates payment attempts, failures, failure rate, and identifies the most common payment failure reason for each payment method.

## Pattern Choice

Uses multiple CTEs, ROW_NUMBER(), GROUP BY, conditional aggregation, and window functions.

## Business Interpretation

This report helps identify payment methods with poor performance and highlights the primary reasons for transaction failures.

## What I'd Ask Next

Are payment failures increasing for specific payment gateways or during peak business hours?

---

# Q7 – Delivery SLA Breach

## What the query does

Measures delivery performance for each carrier and shipping method, including average delivery days, median delivery days, p90 delivery days, late deliveries, and SLA breach rate.

## Pattern Choice

Uses CTEs, PERCENTILE_CONT(), aggregate functions, GROUP BY, and conditional aggregation.

## Business Interpretation

This identifies delivery partners consistently missing the 5-day delivery SLA and helps operations teams improve logistics performance.

## What I'd Ask Next

Are SLA breaches concentrated in specific cities or regions?

---

# Q8 – Customer Lifetime Value

## What the query does

Calculates lifetime revenue, average order value, purchase history, and customer LTV buckets.

## Pattern Choice

Uses CTEs, CASE statements, aggregate functions, and window functions.

## Business Interpretation

The report identifies high-value customers and measures how much revenue each LTV segment contributes to the business.

## What I'd Ask Next

Which acquisition channels generate the highest-value customers?

---

# Q9 – Repeat Purchase Interval

## What the query does

Measures the number of days between consecutive customer purchases.

## Pattern Choice

Uses LEAD(), window functions, DATE calculations, and aggregate functions.

## Business Interpretation

This helps determine the ideal timing for customer re-engagement campaigns and win-back marketing.

## What I'd Ask Next

How does the repeat purchase interval vary across customer segments?

---

# Q10 – Attribution Comparison

## What the query does

Compares revenue allocation using First-Touch and Last-Touch marketing attribution models.

## Pattern Choice

Uses ROW_NUMBER(), multiple CTEs, UNION ALL, window functions, and aggregate functions.

## Business Interpretation

This highlights which marketing channels introduce customers and which channels are most effective at converting purchases.

## What I'd Ask Next

How would a multi-touch attribution model change marketing budget allocation?
