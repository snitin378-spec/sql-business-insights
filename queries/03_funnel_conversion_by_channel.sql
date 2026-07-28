-- Q3: Funnel Conversion by Acquisition Channel
-- Owner: Nithin
-- Business Question:
-- Where in the funnel does each channel's traffic leak?
--
-- Sanity Checks:
-- 1. All conversion rates should be between 0 and 1.
-- 2. Sessions >= Product Views >= Add to Cart >= Checkout >= Purchase.

select
    coalesce(sc.channel, 'direct') as channel,

    count(distinct se.session_id) as sessions,

    count(distinct se.session_id)
        filter (where se.event_type = 'product_view')
        as product_view_sessions,

    count(distinct se.session_id)
        filter (where se.event_type = 'add_to_cart')
        as add_to_cart_sessions,

    count(distinct se.session_id)
        filter (where se.event_type = 'begin_checkout')
        as begin_checkout_sessions,

    count(distinct se.session_id)
        filter (where se.event_type = 'purchase')
        as purchase_sessions,

    round(
        count(distinct se.session_id)
            filter (where se.event_type = 'add_to_cart')::numeric
        /
        nullif(
            count(distinct se.session_id)
                filter (where se.event_type = 'product_view'),
            0
        ),
        4
    ) as view_to_cart_rate,

    round(
        count(distinct se.session_id)
            filter (where se.event_type = 'begin_checkout')::numeric
        /
        nullif(
            count(distinct se.session_id)
                filter (where se.event_type = 'add_to_cart'),
            0
        ),
        4
    ) as cart_to_checkout_rate,

    round(
        count(distinct se.session_id)
            filter (where se.event_type = 'purchase')::numeric
        /
        nullif(
            count(distinct se.session_id)
                filter (where se.event_type = 'begin_checkout'),
            0
        ),
        4
    ) as checkout_to_purchase_rate,

    round(
        count(distinct se.session_id)
            filter (where se.event_type = 'purchase')::numeric
        /
        nullif(
            count(distinct se.session_id),
            0
        ),
        4
    ) as session_to_purchase_rate

from ecom.session_events se

left join ecom.session_channels sc
    on se.session_id = sc.session_id

group by
    coalesce(sc.channel, 'direct')

order by
    session_to_purchase_rate desc,
    sessions desc;
