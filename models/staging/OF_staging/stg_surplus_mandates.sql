
with user_period_filter as
(
    select * from {{ref('stg_user_period_filter')}}
),

surplus_mandates as
(
    select ssm.member_id, ssm.period_id, collector_type
    , sum(case when  status = 'closed' and invoiceable_at is not null and collector_type = "CheckIn" and settlement_status = "settled" then payout_price/100 else null end) as additional_workout_cost
    , sum(case when  status = 'closed' and invoiceable_at is not null and collector_type = "CheckIn" and settlement_status = "settled" then price/100 else null end) as additional_workout_revenue
    from {{ source('output_looker','sq_surplus_mandates') }} ssm
    inner join user_period_filter
    on ssm.member_id = user_period_filter.member_id
    and ssm.period_id = user_period_filter.period_id
--    where collector_type = 'CheckIn'
    group by 1,2,3
)

select * from surplus_mandates