-- in this step we are summarising the amount of followers that each creator gained on the previous day (compared to when the script is run)

CREATE TABLE IF NOT EXISTS datamodeling.active_creators_daily_followers_tmp AS

(

  SELECT

    followed_id AS creator_id,
    DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AS active_date,
    COUNT(DISTINCT id) AS followers_gained

  FROM big_data.subscription_following

  WHERE TIMESTAMP_TRUNC(created, DAY) < TIMESTAMP(EXTRACT(DATE FROM CURRENT_TIMESTAMP()))

  AND TIMESTAMP_TRUNC(created, DAY) = TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))

  GROUP BY 1,2

  HAVING COUNT(DISTINCT id) > 0

);
