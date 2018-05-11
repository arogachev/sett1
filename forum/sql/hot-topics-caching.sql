SELECT * FROM (
  SELECT DISTINCT ON (posts.topic_id)
    topics.name AS topic_name,
    posts.content AS last_post_content,
    users.name AS last_post_author,
    posts.created_at AS last_post_created_at
  FROM forum_posts AS posts
  LEFT JOIN forum_topics AS topics ON posts.topic_id = topics.id
  LEFT JOIN forum_users AS users ON posts.author_id = users.id
  WHERE topics.participants_count > 4
  ORDER BY posts.topic_id, posts.created_at DESC
  LIMIT 10
) AS t
ORDER BY t.last_post_created_at DESC
