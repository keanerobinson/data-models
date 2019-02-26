-- this step joins the fields from the previous 11 steps and matches the table schema that gets loaded to on a daily basis

CREATE TABLE IF NOT EXISTS datamodeling.active_creators_staging AS

(

SELECT

  -- creator fields from user auth table
  au.creator_id,
  au.active_date,
  au.username,
  au.display_name,
  au.url,
  au.email,
  au.last_login,
  au.date_joined,
  au.country,
  au.city,
  au.gender,
  au.birthyear,
  au.created_country,
  au.created_ip_address,
  au.follower_count,
  au.following_count,
  au.free_pro_features,
  au.free_premium_features,
  au.disable_email,
  au.is_confirmed_human,
  au.confirmed_human_at,
  au.last_known_country,
  au.hide_stats,
  au.is_select_creator,

  -- daily stats aggregations
  dc.comments_gained,
  df.favorites_gained,
  dfo.followers_gained,
  dp.listener_minutes_gained,
  dp.promoted_lms_gained,
  dp.organic_lms_gained,
  dp.plays_gained,
  dp.return_plays_gained,
  dp.percentage_of_return_plays,
  dr.reposts_gained,
  du.shows_uploaded,

  -- overall stats aggregations
  oc.overall_shows_uploaded,
  oc.average_plays_per_show,
  oc.average_listener_minutes_per_show,
  oc.overall_reposts,
  oc.average_reposts_per_show,
  oc.overall_favorites,
  oc.average_favorites_per_show,
  oc.average_quality_score,
  oc.average_hotness_score,
  oc.average_mixcloud_score,
  oc.average_play_length_in_minutes,
  oc.average_show_length_in_minutes,
  oc.average_play_percentage,
  oco.overall_comments,
  oco.average_comments_per_show,
  op.overall_listener_minutes,
  op.overall_promoted_lms,
  op.overall_organic_lms,
  op.overall_plays,
  op.overall_organic_plays,
  op.overall_promoted_plays,
  op.overall_return_plays,
  op.overall_percentage_of_return_plays,

  -- rolling stats
  rt.listener_minutes_28_days,
  rt.plays_28_days,
  rt.creator_tier

FROM

  datamodeling.active_creators_user_auth_tmp AS au

  LEFT JOIN datamodeling.active_creators_daily_comments_tmp AS dc

    ON au.creator_id = dc.creator_id AND au.active_date = dc.active_date

  LEFT JOIN datamodeling.active_creators_daily_favorites_tmp AS df

    ON au.creator_id = df.creator_id AND au.active_date = df.active_date

  LEFT JOIN datamodeling.active_creators_daily_followers_tmp AS dfo

    ON au.creator_id = dfo.creator_id AND au.active_date = dfo.active_date

  LEFT JOIN datamodeling.active_creators_daily_playlog_tmp AS dp

    ON au.creator_id = dp.creator_id AND au.active_date = dp.active_date

  LEFT JOIN datamodeling.active_creators_daily_reposts_tmp AS dr

    ON au.creator_id = dr.creator_id AND au.active_date = dr.active_date

  LEFT JOIN datamodeling.active_creators_daily_uploads_tmp AS du

    ON au.creator_id = du.creator_id AND au.active_date = du.active_date

  LEFT JOIN datamodeling.active_creators_overall_cloudcast_tmp AS oc

    ON au.creator_id = oc.creator_id AND au.active_date = oc.active_date

  LEFT JOIN datamodeling.active_creators_overall_comments_tmp AS oco

    ON au.creator_id = oco.creator_id AND au.active_date = oco.active_date

  INNER JOIN datamodeling.active_creators_overall_playlog_tmp AS op

    ON au.creator_id = op.creator_id AND au.active_date = op.active_date

  INNER JOIN datamodeling.active_creators_rolling_tiers_tmp AS rt

    ON au.creator_id = rt.creator_id AND au.active_date = rt.active_date

);
