{{
    config(
        MATERIALIZED = 'ephemeral'
    )
}}


WITH raw_comments AS(
    SELECT * FROM {{source('AIRSTATS','comments')}}
)
SELECT
    id AS comment_id,
    airport_ident,
    comment_date AS comment_timestamp,
    member_nickname,
    subject AS comment_subject,
    body AS comment_body
FROM raw_comments