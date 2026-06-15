SELECT *
FROM {{ ref('silver_airport_comments') }}
WHERE COMMENT_BODY IS NULL
LIMIT 1