
WITH scd_silver_airports(

SELECT *  FROM {{ref('scd_silver_airports')}}

)
SELECT * FROM scd_silver_airports WHERE airport_ident = '00A'
