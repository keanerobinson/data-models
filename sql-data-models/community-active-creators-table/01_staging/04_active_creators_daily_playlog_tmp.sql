-- in this step we are summarising the creator's plays (compared to when the script is run)

CREATE TABLE IF NOT EXISTS datamodeling.active_creators_daily_playlog_tmp AS

(

  SELECT

    mc.owner_id AS creator_id,
    DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AS active_date,
    SUM(pl.pings) AS listener_minutes_gained,
    SUM(IF(pl.created_source_detail LIKE '%Promoted%', pings, 0)) as promoted_lms_gained,
    (SUM(pl.pings)-SUM(IF(pl.created_source_detail LIKE '%Promoted%', pings, 0))) AS organic_lms_gained,
    COUNT(*) AS plays_gained,
    COUNT(*) - COUNT(DISTINCT pl.user_id) AS return_plays_gained,
    (COUNT(*) - COUNT(DISTINCT pl.user_id)) / COUNT(*) AS percentage_of_return_plays

  FROM big_data.popularity_playlog AS pl

  INNER JOIN big_data.music_cloudcast AS mc

    ON pl.cloudcast_id = mc.id

  WHERE TIMESTAMP_TRUNC(pl.created, DAY) < TIMESTAMP(EXTRACT(DATE FROM CURRENT_TIMESTAMP()))

    AND TIMESTAMP_TRUNC(pl.created, DAY) = TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))

    AND pl.pings < (mc.audio_length / 60)

  GROUP BY 1

);
