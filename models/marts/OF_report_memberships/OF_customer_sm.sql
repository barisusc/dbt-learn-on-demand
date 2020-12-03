
with user_period_filter as
(
    select * from {{ref('stg_user_period_filter')}}
),

surplus_mandates as
(
    select * from {{ref('stg_surplus_mandates')}}
),

mem_additional_workout_details as
(
    select user_period_filter.member_id
    , sum(additional_workout_cost) as additional_workout_tot_cost
    , sum(additional_workout_revenue) as additional_workout_tot_revenue
    from user_period_filter
    join surplus_mandates
    on user_period_filter.member_id = surplus_mandates.member_id
    and user_period_filter.period_id = surplus_mandates.period_id
    where additional_workout_cost is not null
    group by 1
)
select * from mem_additional_workout_details