SELECT 
latest_row.id as id,
latest_row.member_id as member_id,
latest_row.starts_at as starts_at,
latest_row.city_product_id as city_product_id,
latest_row.status as status,
latest_row.recurring_required as recurring_required,
latest_row.convert_at as convert_at,
latest_row.created_at as created_at,
latest_row.updated_at as updated_at
FROM (
  SELECT ARRAY_AGG(table ORDER BY updated_at DESC LIMIT 1)[OFFSET(0)] AS latest_row
  FROM {{ source('mysql_stitch_raw2','membership_settings') }} AS table
  GROUP BY id
)