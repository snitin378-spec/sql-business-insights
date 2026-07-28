-- Q10: Attribution Comparison — First Touch vs Last Touch
-- Owner: Nithin
-- Business question:
-- Which channels introduce customers and which channels close purchases?
--
-- Sanity checks:
-- 1. First-touch revenue equals last-touch revenue.
-- 2. Both totals equal non-cancelled order revenue.
-- 3. Share of revenue sums to 1 for each attribution model.

with ranked_touches as (

    select
        att.session_id
      , att.channel
      , att.touched_at

      , row_number() over (
            partition by att.session_id
            order by att.touched_at asc
        ) as first_touch_rank

      , row_number() over (
            partition by att.session_id
            order by att.touched_at desc
        ) as last_touch_rank

    from ecom.attribution_touches att

)

, session_attribution as (

    select
        session_id

      , max(channel) filter (
            where first_touch_rank = 1
        ) as first_touch_channel

      , max(channel) filter (
            where last_touch_rank = 1
        ) as last_touch_channel

    from ranked_touches

    group by
        session_id

)

, eligible_orders as (

    select
        o.order_id
      , o.session_id
      , o.subtotal as revenue

    from ecom.orders o

    where lower(o.status) <> 'cancelled'

)

, attributed_orders as (

    select
        eo.order_id
      , eo.revenue
      , coalesce(sa.first_touch_channel, 'direct')
            as first_touch_channel
      , coalesce(sa.last_touch_channel, 'direct')
            as last_touch_channel

    from eligible_orders eo

    left join session_attribution sa
      on eo.session_id = sa.session_id

)

, attribution_results as (

    select
        'first_touch' as attribution_model
      , first_touch_channel as channel
      , sum(revenue) as revenue
      , count(distinct order_id) as orders

    from attributed_orders

    group by
        first_touch_channel

    union all

    select
        'last_touch' as attribution_model
      , last_touch_channel as channel
      , sum(revenue) as revenue
      , count(distinct order_id) as orders

    from attributed_orders

    group by
        last_touch_channel

)

select
    attribution_model
  , channel
  , revenue
  , orders

  , round(
        revenue::numeric
        / nullif(
            sum(revenue) over (
                partition by attribution_model
            ),
            0
        )
      , 4
    ) as share_of_revenue

from attribution_results

order by
    attribution_model
  , revenue desc;
