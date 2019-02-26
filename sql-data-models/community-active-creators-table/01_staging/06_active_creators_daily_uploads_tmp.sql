-- in this step we are summarising the amount of shows uploaded by the creator on the previous day (compared to when the script is run)

CREATE TABLE IF NOT EXISTS datamodeling.active_creators_daily_uploads_tmp AS

(

  SELECT

    owner_id AS creator_id,
    DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AS active_date,
    COUNT(DISTINCT id) AS shows_uploaded

  FROM big_data.music_cloudcast


  WHERE TIMESTAMP_TRUNC(created, DAY) < TIMESTAMP(EXTRACT(DATE FROM CURRENT_TIMESTAMP()))

    AND TIMESTAMP_TRUNC(created, DAY) = TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))

  GROUP BY 1
  HAVING COUNT(DISTINCT id) > 0

);
