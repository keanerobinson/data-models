-- in this step we are summarising the amount of favorites that each creator drove on the previous day (compared to when the script is run)

CREATE TABLE IF NOT EXISTS datamodeling.active_creators_daily_favorites_tmp AS

(

  SELECT

    mc.owner_id AS creator_id,
    DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AS active_date,
    COUNT(*) AS favorites_gained

  FROM big_data.favorites_favorite AS f

  INNER JOIN big_data.music_cloudcast AS mc

    ON f.cloudcast_id = mc.id

  WHERE TIMESTAMP_TRUNC(f.created, DAY) < TIMESTAMP(EXTRACT(DATE FROM CURRENT_TIMESTAMP()))

    AND TIMESTAMP_TRUNC(f.created, DAY) = TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))

  GROUP BY 1

);
