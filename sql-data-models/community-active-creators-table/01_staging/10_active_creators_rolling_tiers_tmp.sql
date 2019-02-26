-- in this step we are using the community tier definitions to segment users based on their performance over the past 28 days

CREATE TABLE IF NOT EXISTS datamodeling.active_creators_rolling_tiers_tmp AS

(

  SELECT

  creator_id,
  DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AS active_date,
  listener_minutes_28_days,
  plays_28_days,

  CASE

     WHEN listener_minutes_28_days >= 200000 THEN 'tier 1'
     WHEN listener_minutes_28_days <200000 AND listener_minutes_28_days >= 100000 THEN 'tier 2'
     WHEN listener_minutes_28_days <100000 AND listener_minutes_28_days >= 50000 THEN 'tier 3'
     WHEN listener_minutes_28_days <50000 AND listener_minutes_28_days >= 10000 THEN 'tier 4'

  ELSE 'below minimum tier' END AS creator_tier

  FROM

   (SELECT

     mc.owner_id AS creator_id,
     SUM(pl.pings) AS listener_minutes_28_days,
     COUNT(*) AS plays_28_days

   FROM big_data.popularity_playlog AS pl

   INNER JOIN big_data.music_cloudcast AS mc

     ON pl.cloudcast_id = mc.id

   WHERE TIMESTAMP_TRUNC(pl.created, DAY) < TIMESTAMP(EXTRACT(DATE FROM CURRENT_TIMESTAMP()))

   AND TIMESTAMP_TRUNC(pl.created, DAY) >= TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 29 DAY))

   GROUP BY 1)

);
