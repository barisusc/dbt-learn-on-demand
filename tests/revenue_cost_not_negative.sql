select period_id, additional_workout_cost, additional_workout_revenue
from {{ref('stg_surplus_mandates')}}
where not (additional_workout_cost >= 0 and  additional_workout_revenue >= 0)