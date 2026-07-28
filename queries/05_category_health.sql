-- Q5: Category Health
-- Business Question:
-- Which product categories generate the highest revenue and refund amount?

with category_sales as (

    select
        c.category_name as category
      , count(distinct oi.order_id) as orders_with_category
      , sum(oi.qty) as units_sold
      , sum(oi.line_total) as revenue

    from ecom.order_items oi

    join ecom.product_variants pv
      on oi.variant_id = pv.variant_id

    join ecom.products p
      on pv.product_id = p.product_id

    join ecom.categories c
      on p.category_id = c.category_id

    group by c.category_name

)

, category_refunds as (

    select
        c.category_name as category
      , count(distinct r.refund_id) as refunds
      , sum(r.amount) as refund_amount

    from ecom.refunds r

    join ecom.order_items oi
      on r.order_id = oi.order_id

    join ecom.product_variants pv
      on oi.variant_id = pv.variant_id

    join ecom.products p
      on pv.product_id = p.product_id

    join ecom.categories c
      on p.category_id = c.category_id

    where r.status = 'succeeded'

    group by c.category_name

)

select

    cs.category
  , cs.orders_with_category
  , cs.units_sold
  , cs.revenue

  , coalesce(cr.refunds,0) as refunds

  , round(
        coalesce(cr.refunds,0) *100.0
        / nullif(cs.orders_with_category,0)
    ,2) as return_rate_pct

  , coalesce(cr.refund_amount,0) as refund_amount

from category_sales cs

left join category_refunds cr
       on cs.category = cr.category

order by cs.revenue desc;
