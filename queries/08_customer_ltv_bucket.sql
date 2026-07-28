-- Q8: Customer Lifetime Value (LTV)
-- Business Question:
-- Who are our highest-value customers and how much revenue comes from each LTV bucket?

with customer_ltv as (

    select
        o.customer_id
      , min(o.created_at::date) as first_order_date
      , max(o.created_at::date) as last_order_date
      , count(distinct o.order_id) as total_orders
      , sum(o.subtotal) as total_revenue
      , round(avg(o.subtotal),2) as aov

    from ecom.orders o

    where lower(o.status) <> 'cancelled'

    group by
        o.customer_id

),

customer_bucket as (

    select
        *

      , case
            when total_revenue < 1000 then '0-999'
            when total_revenue < 5000 then '1000-4999'
            when total_revenue < 20000 then '5000-19999'
            else '20000+'
        end as ltv_bucket

    from customer_ltv

)

select

    customer_id,
    first_order_date,
    last_order_date,
    total_orders,
    total_revenue,
    aov,
    ltv_bucket,

    round(

        sum(total_revenue)
            over(partition by ltv_bucket)

        /

        sum(total_revenue)
            over()

    ,4)

    as ltv_bucket_share_of_revenue

from customer_bucket

order by
    total_revenue desc;
