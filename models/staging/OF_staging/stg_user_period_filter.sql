
with user_period_filter as
(
select distinct member_id, id as period_id from {{ source('output_looker','sq_periods') }}
where partition_date >= '2020-01-01'
and partition_date < '2020-11-01'
)

select * from user_period_filter