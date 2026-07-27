-- Q2: Monthly Signup Cohort Retention
-- Owner: Nithin
-- Last Updated: 2026-07-27
-- Business Question:
-- For each month's new signups, how many customers returned
-- in Month 1, Month 2 and Month 3?
--
-- Sanity Checks:
-- 1. cohort_size equals distinct customers signed up in that month.
-- 2. Retention rates are between 0 and 1.
-- 3. Cancelled orders are excluded.
-- 4. Future (censored) months are shown as NULL.

with latest_month as (

    select
        date_trunc('month', max(created_at))::date as latest_order_month
    from ecom.orders

),

customer_cohorts as (

    select
        customer_id,
        date_trunc('month', created_at)::date as cohort_month

    from ecom.customers

),

customer_orders as (

    select
        customer_id,
        order_id,
        date_trunc('month', created_at)::date as order_month

    from ecom.orders

    where lower(status) <> 'cancelled'

),

cohort_activity as (

    select
        cc.customer_id,
        cc.cohort_month,

        (
            extract(year from age(co.order_month, cc.cohort_month)) * 12
            +
            extract(month from age(co.order_month, cc.cohort_month))
        ) as month_number

    from customer_cohorts cc

    left join customer_orders co
        on cc.customer_id = co.customer_id

)

select

    ca.cohort_month,

    count(distinct ca.customer_id) as cohort_size,

    count(distinct ca.customer_id)
        filter (where month_number = 1) as m1_retained,

    count(distinct ca.customer_id)
        filter (where month_number = 2) as m2_retained,

    count(distinct ca.customer_id)
        filter (where month_number = 3) as m3_retained,

    case
        when lm.latest_order_month >= ca.cohort_month + interval '1 month'
        then round(
            count(distinct ca.customer_id)
            filter (where month_number = 1)
            * 1.0
            /
            nullif(count(distinct ca.customer_id),0),
            2
        )
        else null
    end as m1_retention_rate,

    case
        when lm.latest_order_month >= ca.cohort_month + interval '2 month'
        then round(
            count(distinct ca.customer_id)
            filter (where month_number = 2)
            * 1.0
            /
            nullif(count(distinct ca.customer_id),0),
            2
        )
        else null
    end as m2_retention_rate,

    case
        when lm.latest_order_month >= ca.cohort_month + interval '3 month'
        then round(
            count(distinct ca.customer_id)
            filter (where month_number = 3)
            * 1.0
            /
            nullif(count(distinct ca.customer_id),0),
            2
        )
        else null
    end as m3_retention_rate

from cohort_activity ca

cross join latest_month lm

group by
    ca.cohort_month,
    lm.latest_order_month

order by
    ca.cohort_month;
