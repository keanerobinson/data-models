-- this step pulls all of the useful fields from the auth_user table

CREATE TABLE IF NOT EXISTS datamodeling.active_creators_user_auth_tmp AS

(

  WITH select_creators AS (SELECT DISTINCT uploader_id FROM big_data.subscription_plan WHERE statement_descriptor = 'Mixcloud Select')

  SELECT

    au.id AS creator_id,
    DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AS active_date,
    au.username,
    au.display_name,
    CONCAT('www.mixcloud.com/', au.username) AS url,
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
    CASE WHEN sc.uploader_id IS NOT NULL THEN 1 ELSE 0 END AS is_select_creator

  FROM big_data.auth_user AS au

  LEFT JOIN select_creators AS sc ON au.id = sc.uploader_id

  WHERE id IN (SELECT DISTINCT owner_id AS id FROM big_data.music_cloudcast)

);
