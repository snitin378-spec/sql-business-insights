-- Q7: Delivery SLA Breach by Carrier and Shipping Method
-- Owner: Nithin
-- Business Question:
-- Which carriers and shipping methods are missing the 5-day delivery SLA?
--
-- Sanity Checks:
-- 1. avg_delivery_days should be less than or equal to p90_delivery_days.
-- 2. late_rate should be between 0 and 1.
-- 3. Shipments with delivered_at is null are excluded.

with delivered_shipments as (

    select
        sc.carrier_name as carrier
      , sm.method_name as shipping_method
      , s.order_id
      , s.shipped_at::date as shipped_date
      , s.delivered_at::date as delivered_date
      , s.delivered_at::date - s.shipped_at::date as delivery_days

    from ecom.shipments s

    join ecom.shipping_carriers sc
      on s.carrier_id = sc.carrier_id

    join ecom.shipping_methods sm
      on s.shipping_method_id = sm.shipping_method_id

    where s.delivered_at is not null

)

select
    carrier
  , shipping_method
  , count(distinct order_id) as delivered_orders

  , round(
        avg(delivery_days)::numeric
      , 2
    ) as avg_delivery_days

  , round(
        percentile_cont(0.5)
            within group (order by delivery_days)::numeric
      , 2
    ) as median_delivery_days

  , round(
        percentile_cont(0.9)
            within group (order by delivery_days)::numeric
      , 2
    ) as p90_delivery_days

  , count(*) filter (
        where delivery_days > 5
    ) as late_deliveries

  , round(
        count(*) filter (
            where delivery_days > 5
        )::numeric
        / nullif(count(*), 0)
      , 4
    ) as late_rate

from delivered_shipments

group by
    carrier
  , shipping_method

order by
    late_rate desc
  , p90_delivery_days desc;
