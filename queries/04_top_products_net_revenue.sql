-- Q4: Top Products by Net Revenue
-- Owner: Nithin
-- Business Question:
-- Which products generate the highest net revenue after refunds?
--
-- Sanity Check:
-- Gross Revenue = Sum of line_total
-- Net Revenue = Gross Revenue - Refund Amount

with product_sales as (

    select
        pv.product_id,
        p.product_name,
        sum(oi.line_total) as gross_revenue,
        count(distinct oi.order_id) as total_orders,
        sum(oi.qty) as units_sold
    from ecom.order_items oi
    join ecom.product_variants pv
        on oi.variant_id = pv.variant_id
    join ecom.products p
        on pv.product_id = p.product_id
    group by
        pv.product_id,
        p.product_name

),

product_refunds as (

    select
        pv.product_id,
        sum(r.amount) as refund_amount
    from ecom.refunds r
    join ecom.order_items oi
        on r.order_id = oi.order_id
    join ecom.product_variants pv
        on oi.variant_id = pv.variant_id
    where lower(r.status) = 'succeeded'
    group by
        pv.product_id

)

select

    ps.product_id,
    ps.product_name,
    ps.gross_revenue,
    ps.total_orders,
    ps.units_sold,

    coalesce(pr.refund_amount,0) as refund_amount,

    ps.gross_revenue - coalesce(pr.refund_amount,0) as net_revenue

from product_sales ps

left join product_refunds pr
    on ps.product_id = pr.product_id

order by
    net_revenue desc
limit 20;
