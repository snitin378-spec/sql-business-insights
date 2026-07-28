-- Q6: Payment Failure Analysis
-- Business Question:
-- Which payment methods fail the most, and what is the top failure reason?
--
-- Sanity Check:
-- failure_rate and top_error_share_of_failures should be between 0 and 1.

with payment_summary as (

    select
        pm.method_name as payment_method,
        count(*) as attempts,
        count(*) filter (where lower(pt.status) = 'failed') as failures
    from ecom.payment_intents pi

    join ecom.payment_methods pm
        on pi.payment_method_id = pm.payment_method_id

    join ecom.payment_transactions pt
        on pi.payment_intent_id = pt.payment_intent_id

    group by
        pm.method_name

),

error_ranking as (

    select
        pm.method_name as payment_method,
        pt.error_code,
        pt.error_message,
        count(*) as error_count,

        row_number() over (
            partition by pm.method_name
            order by count(*) desc
        ) as rn

    from ecom.payment_intents pi

    join ecom.payment_methods pm
        on pi.payment_method_id = pm.payment_method_id

    join ecom.payment_transactions pt
        on pi.payment_intent_id = pt.payment_intent_id

    where lower(pt.status) = 'failed'

    group by
        pm.method_name,
        pt.error_code,
        pt.error_message

)

select

    ps.payment_method,
    ps.attempts,
    ps.failures,

    round(
        ps.failures::numeric
        / nullif(ps.attempts,0),
        4
    ) as failure_rate,

    er.error_code as top_error_code,
    er.error_message as top_error_message,

    round(
        er.error_count::numeric
        / nullif(ps.failures,0),
        4
    ) as top_error_share_of_failures

from payment_summary ps

left join error_ranking er
    on ps.payment_method = er.payment_method
   and er.rn = 1

order by
    failure_rate desc,
    failures desc;
