-- Q1: Daily Business Summary with DoD and Same Weekday WoW
-- Owner: Nithin
-- Last Updated: 2026-07-27
-- Business Question:
-- How are we doing today compared to yesterday and the same weekday last week?
--
-- Sanity Checks:
-- 1. paid_order_rate should be between 0 and 1.
-- 2. cancelled_order_rate should be between 0 and 1.
-- 3. Sum of daily orders should equal total orders.

with daily_summary as (

    select
        date(created_at) as order_date,
        count(order_id) as orders,
        sum(subtotal) as revenue,

        round(
            sum(subtotal) * 1.0 /
            nullif(count(order_id), 0),
            2
        ) as aov,

        count(*) filter (
            where lower(status) = 'paid'
        ) * 1.0 / nullif(count(*), 0) as paid_order_rate,

        count(*) filter (
            where lower(status) = 'cancelled'
        ) * 1.0 / nullif(count(*), 0) as cancelled_order_rate

    from ecom.orders

    group by date(created_at)

),

daily_refunds as (

    select
        date(created_at) as refund_date,
        sum(amount) as refunds_amount

    from ecom.refunds

    where lower(status) = 'succeeded'

    group by date(created_at)

)

select

    ds.order_date,
    ds.orders,
    ds.revenue,
    ds.aov,
    ds.paid_order_rate,
    ds.cancelled_order_rate,

    coalesce(dr.refunds_amount, 0) as refunds_amount,

    lag(ds.revenue, 1) over (
        order by ds.order_date
    ) as yesterday_revenue,

    round(

        (
            ds.revenue
            -
            lag(ds.revenue, 1) over (
                order by ds.order_date
            )
        ) * 100.0

        /

        nullif(

            lag(ds.revenue, 1) over (
                order by ds.order_date
            ),

            0

        ),

        2

    ) as revenue_vs_yesterday_pct,

    lag(ds.revenue, 7) over (
        order by ds.order_date
    ) as last_week_revenue,

    round(

        (
            ds.revenue
            -
            lag(ds.revenue, 7) over (
                order by ds.order_date
            )
        ) * 100.0

        /

        nullif(

            lag(ds.revenue, 7) over (
                order by ds.order_date
            ),

            0

        ),

        2

    ) as revenue_vs_last_weekday_pct

from daily_summary ds

left join daily_refunds dr
    on ds.order_date = dr.refund_date

order by ds.order_date;
