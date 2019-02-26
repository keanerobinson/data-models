-- to keep our db tidy, we delete all of the temporary tables once all of the data model steps have been run.

DROP TABLE IF EXISTS datamodeling.active_creators_daily_comments_tmp;
DROP TABLE IF EXISTS datamodeling.active_creators_daily_favorites_tmp;
DROP TABLE IF EXISTS datamodeling.active_creators_daily_followers_tmp;
DROP TABLE IF EXISTS datamodeling.active_creators_daily_playlog_tmp;
DROP TABLE IF EXISTS datamodeling.active_creators_daily_reposts_tmp;
DROP TABLE IF EXISTS datamodeling.active_creators_daily_uploads_tmp;
DROP TABLE IF EXISTS datamodeling.active_creators_overall_cloudcast_tmp;
DROP TABLE IF EXISTS datamodeling.active_creators_overall_comments_tmp;
DROP TABLE IF EXISTS datamodeling.active_creators_overall_playlog_tmp;
DROP TABLE IF EXISTS datamodeling.active_creators_rolling_tiers_tmp;
DROP TABLE IF EXISTS datamodeling.active_creators_user_auth_tmp;
DROP TABLE IF EXISTS datamodeling.active_creators_staging;
