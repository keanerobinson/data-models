-- in this step we are building a number of metrics based on the playlog (one row per play)

CREATE TABLE IF NOT EXISTS datamodeling.active_creators_overall_playlog_tmp AS

(

  SELECT

    mc.owner_id AS creator_id,
    DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AS active_date,
    SUM(pl.pings) AS overall_listener_minutes,
    SUM(IF(pl.created_source_detail LIKE '%Promoted%', pings, 0)) as overall_promoted_lms,
    (SUM(pl.pings)-SUM(IF(pl.created_source_detail LIKE '%Promoted%', pings, 0))) AS overall_organic_lms,
    COUNT(*) AS overall_plays,
    COUNT(*) - SUM(CASE WHEN pl.created_source_detail LIKE '%Promoted%' THEN 1 ELSE 0 END) AS overall_organic_plays,
    SUM(CASE WHEN pl.created_source_detail LIKE '%Promoted%' THEN 1 ELSE 0 END) AS overall_promoted_plays,
    COUNT(*) - COUNT(DISTINCT user_id) AS overall_return_plays,
    (COUNT(*) - COUNT(DISTINCT user_id)) / COUNT(*) AS overall_percentage_of_return_plays



  FROM big_data.popularity_playlog AS pl

  INNER JOIN big_data.music_cloudcast AS mc

    ON pl.cloudcast_id = mc.id

  WHERE pl.pings < (mc.audio_length / 60)

  GROUP BY 1

);
