WITH daily_summary AS
(
    SELECT
        DATE(o.created_at) AS order_date,
        COUNT(o.order_id) AS total_orders,
        SUM(o.subtotal) AS revenue,
        ROUND(SUM(o.subtotal) * 1.0 / COUNT(o.order_id),2) AS aov,

        COUNT(*) FILTER
        (
            WHERE LOWER(o.status)='paid'
        ) AS paid_orders,

        COUNT(*) FILTER
        (
            WHERE LOWER(o.status)='cancelled'
        ) AS cancelled_orders,

        SUM(COALESCE(r.amount,0)) AS refund_amount

    FROM ecom.orders o

    LEFT JOIN ecom.refunds r
        ON o.order_id = r.order_id

    GROUP BY DATE(o.created_at)
)

SELECT
    order_date,
    total_orders,
    revenue,
    aov,
    paid_orders,
    cancelled_orders,
    refund_amount,

    LAG(revenue)
    OVER
    (
        ORDER BY order_date
    ) AS yesterday_revenue,

    revenue -
    LAG(revenue)
    OVER
    (
        ORDER BY order_date
    ) AS revenue_difference

FROM daily_summary

ORDER BY order_date;
