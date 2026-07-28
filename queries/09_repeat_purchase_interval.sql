-- Q9: Repeat Purchase Interval
-- Owner: Nithin
-- Business Question:
-- How long does it take customers to place their next order?
--
-- Sanity Checks:
-- 1. days_to_next_order should never be negative.
-- 2. median_days_to_next_order should be less than or equal to p90_days_to_next_order.
-- 3. Cancelled orders are excluded.

with customer_orders as (

    select
        o.customer_id
      , o.order_id
      , o.created_at
      , lead(o.created_at) over (
            partition by o.customer_id
            order by o.created_at
        ) as next_order_at

    from ecom.orders o

    where lower(o.status) <> 'cancelled'

),

repeat_orders as (

    select
        customer_id
      , order_id
      , created_at::date as order_date
      , next_order_at::date as next_order_date
      , next_order_at::date - created_at::date as days_to_next_order

    from customer_orders

    where next_order_at is not null

)

select
    customer_id
  , order_id
  , order_date
  , next_order_date
  , days_to_next_order

from repeat_orders

order by
    customer_id
  , order_date;
