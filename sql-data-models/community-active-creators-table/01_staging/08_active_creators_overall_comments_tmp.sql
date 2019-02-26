-- in this step we are summarising how each creator's show performs in terms of comments overall

CREATE TABLE IF NOT EXISTS datamodeling.active_creators_overall_comments_tmp AS

(

  SELECT

    mc.owner_id AS creator_id,
    DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AS active_date,
    COUNT(*) AS overall_comments,
    COUNT(*) / COUNT(DISTINCT mc.id) AS average_comments_per_show

  FROM big_data.django_comments AS dc INNER JOIN big_data.music_cloudcast AS mc

    ON dc.object_pk = mc.id

  WHERE dc.content_type_id = 64

    GROUP BY 1

);
