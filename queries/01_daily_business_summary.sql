WITH daily_summary AS
(
    SELECT
        DATE(created_at) AS order_date,
        COUNT(order_id) AS total_orders,
        SUM(subtotal) AS revenue,
        ROUND(SUM(subtotal) * 1.0 / COUNT(order_id), 2) AS aov,
        COUNT(*) FILTER (WHERE LOWER(status) = 'paid') AS paid_orders,
        COUNT(*) FILTER (WHERE LOWER(status) = 'cancelled') AS cancelled_orders
    FROM ecom.orders
    GROUP BY DATE(created_at)
)

SELECT
    order_date,
    total_orders,
    revenue,
    aov,
    paid_orders,
    cancelled_orders,
    LAG(revenue) OVER (ORDER BY order_date) AS yesterday_revenue,
    revenue - LAG(revenue) OVER (ORDER BY order_date) AS revenue_difference
FROM daily_summary
ORDER BY order_date;
