SELECT * FROM (
  SELECT DISTINCT ON (posts.topic_id)
    topics.name AS topic_name,
    posts.content AS last_post_content,
    users.name AS topic_author,
    topics.created_at AS topic_created_at
  FROM forum_posts AS posts
  LEFT JOIN forum_topics AS topics ON posts.topic_id = topics.id
  LEFT JOIN forum_users AS users ON topics.author_id = users.id
  WHERE topics.participants_count > 4
  ORDER BY posts.topic_id, posts.created_at DESC
) AS t
ORDER BY t.topic_created_at DESC
LIMIT 10
