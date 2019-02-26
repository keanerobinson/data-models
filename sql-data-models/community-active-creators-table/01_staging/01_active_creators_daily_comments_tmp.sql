-- in this step we are summarising the amount of comments that each creator drove on the previous day (compared to when the script is run)

CREATE TABLE IF NOT EXISTS datamodeling.active_creators_daily_comments_tmp AS

(

  SELECT

    mc.owner_id AS creator_id,
    DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AS active_date,
    COUNT(*) AS comments_gained

  FROM big_data.django_comments AS dc INNER JOIN big_data.music_cloudcast AS mc

    ON dc.object_pk = mc.id

  WHERE dc.content_type_id = 64

  AND TIMESTAMP_TRUNC(dc.created, DAY) < TIMESTAMP(EXTRACT(DATE FROM CURRENT_TIMESTAMP()))

  AND TIMESTAMP_TRUNC(dc.created, DAY) = TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))

  GROUP BY 1

);
