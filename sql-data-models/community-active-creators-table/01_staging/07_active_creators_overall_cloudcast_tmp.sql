-- in this step we are summarising a creator's overall performance

CREATE TABLE IF NOT EXISTS datamodeling.active_creators_overall_cloudcast_tmp AS

(

SELECT * FROM

  (SELECT

    owner_id AS creator_id,
    DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AS active_date,
    COUNT(DISTINCT id) AS overall_shows_uploaded,
    SUM(plays) / COUNT(DISTINCT id) AS average_plays_per_show,
    SUM(listener_minutes) / COUNT(DISTINCT id) AS average_listener_minutes_per_show,
    SUM(repost_count) AS overall_reposts,
    SUM(repost_count) / COUNT(DISTINCT id) AS average_reposts_per_show,
    SUM(favorite_count) AS overall_favorites,
    SUM(favorite_count) / COUNT(DISTINCT id) AS average_favorites_per_show,
    AVG(quality_score) AS average_quality_score,
    AVG(hotness_score) AS average_hotness_score,
    AVG(mixcloud_score) AS average_mixcloud_score,
    SUM(listener_minutes) / SUM(plays) AS average_play_length_in_minutes,
    AVG(audio_length/60) AS average_show_length_in_minutes,
    (SUM(listener_minutes) / SUM(plays)) / AVG(audio_length/60) AS average_play_percentage

  FROM big_data.music_cloudcast

  WHERE listener_minutes > 0

  AND audio_length > 0

  GROUP BY 1

  HAVING SUM(plays) > 0)

  WHERE average_play_percentage <= 1

);
