SELECT * FROM (
  SELECT DISTINCT ON (posts.topic_id)
    topics.name AS topic_name,
    posts.content AS last_post_content,
    users.name AS last_post_author,
    topics.created_at AS topic_created_at
  FROM forum_posts AS posts
  LEFT JOIN forum_topics AS topics ON posts.topic_id = topics.id
  LEFT JOIN forum_users AS users ON posts.author_id = users.id
  WHERE posts.topic_id IN (
    SELECT subposts.topic_id
    FROM forum_posts AS subposts
    GROUP BY subposts.topic_id HAVING COUNT(DISTINCT subposts.author_id) > 4
  )
  ORDER BY posts.topic_id, posts.created_at DESC
) AS t
ORDER BY t.topic_created_at DESC
LIMIT 10
