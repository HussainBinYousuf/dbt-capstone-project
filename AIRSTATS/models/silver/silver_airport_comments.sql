{{ config(
    materialized='incremental',
    unique_key='comment_id'
) }}

WITH silver_airport_comments AS (

    SELECT *
    FROM {{ ref('src_airport_comments') }}

)

SELECT
    comment_id,
    airport_ident,
    comment_timestamp,
    CASE
        WHEN member_nickname IS NULL THEN '__UNKNOWN__'
        ELSE member_nickname
    END AS member_nickname,
    comment_subject,
    comment_body,
    CURRENT_TIMESTAMP() AS loaded_at

FROM silver_airport_comments

WHERE comment_body IS NOT NULL

{% if is_incremental() %}
  AND comment_id > (
        SELECT COALESCE(MAX(comment_id), 0)
        FROM {{ this }}
  )
{% endif %}