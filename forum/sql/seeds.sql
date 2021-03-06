-- Users

INSERT INTO forum_users (id, email, password, name, joined_at) VALUES
  (1, 'mivanov@example.com', 'pbkdf2_sha256$24000$NiGtvdzxWkOI$LI2cy7OBuW1OewPWJmeMZMh0J85dn3HWFNN6FOBuNe4=', 'Матвей Иванов', '2018-05-05 15:00:00'),
  (2, 'asmirnov@example.com', 'pbkdf2_sha256$24000$lv1eo2EBHj5p$pNaCB7VxsI586+o17o19L+TYzl+w4skDL5i80SeqnoA=', 'Артём Смирнов', '2018-05-05 16:00:00'),
  (3, 'mkuznecov@example.com', 'pbkdf2_sha256$24000$rV7Uivc23wuW$9dia86Q19r7irzyn9dre6b74bX2GNBx0sIBnrxN7l0Q=', 'Максим Кузнецов', '2018-05-05 17:00:00'),
  (4, 'dpopov@example.com', 'pbkdf2_sha256$24000$BoH2IXxaPRB6$HyWSdvnIEnyF9BWSiIvsQ8hPuf9vAG1ueB7zdfLOBFQ=', 'Дмитрий Попов', '2018-05-05 18:00:00'),
  (5, 'vosipov@example.com', 'pbkdf2_sha256$100000$c89MygBqMX9y$FfT+HBCRMwuizVrzYCGpVthO1DUuWF0Q4oLbkaGtQyA=', 'Владимир Осипов', '2018-05-05 19:00:00');

-- Users' profiles

INSERT INTO forum_users_profiles(id, user_id, description, avatar, location, born_at) VALUES
  (1, 1, '', '', '', NULL),
  (2, 2, '', '', '', NULL),
  (3, 3, '', '', '', NULL),
  (4, 4, '', '', '', NULL),
  (5, 5, '', '', '', NULL);

-- Forums

INSERT INTO forum_forums(id, parent_id, name, description, image, topics_count, posts_count, created_at) VALUES
  (1, NULL, 'Главный форум', '', '', 6, 24, '2018-05-05 20:00:00'),
  (2, 1, 'Общие вопросы', '', '', 6, 24, '2018-05-05 21:00:00');

-- Topics

INSERT INTO forum_topics(id, forum_id, author_id, name, description, image, posts_count, participants_count, views_count, pinned, created_at) VALUES
  (1, 1, 1, 'Тема 1 (1 сообщение, 1 пользователь)', '', '', 1, 1, 1, FALSE, '2018-05-05 22:00:00'),
  (2, 1, 2, 'Тема 2 (3 сообщения, 3 пользователя)', '', '', 3, 3, 3, FALSE, '2018-05-05 23:00:00'),
  (3, 1, 3, 'Тема 3 (4 сообщения, 4 пользователя)', '', '', 4, 4, 4, FALSE, '2018-05-06 00:00:00'),
  (4, 1, 4, 'Тема 4 (5 сообщений, 2 пользователя)', '', '', 5, 2, 5, FALSE, '2018-05-06 01:00:00'),
  (5, 1, 5, 'Тема 5 (5 сообщений, 5 пользователей)', '', '', 5, 5, 5, FALSE, '2018-05-06 02:00:00'),
  (6, 1, 1, 'Тема 6 (6 сообщений, 5 пользователей)', '', '', 6, 5, 6, FALSE, '2018-05-06 03:00:00');

-- Topics' views

INSERT INTO forum_topics_views(id, topic_id, user_id, viewed_at) VALUES
  (1, 1, 1, '2018-05-06 04:00:05'),

  (2, 2, 1, '2018-05-06 05:00:05'),
  (3, 2, 2, '2018-05-06 06:00:00'),
  (4, 2, 3, '2018-05-06 07:00:00'),

  (5, 3, 1, '2018-05-06 08:00:05'),
  (6, 3, 2, '2018-05-06 09:00:00'),
  (7, 3, 3, '2018-05-06 10:00:00'),
  (8, 3, 4, '2018-05-06 11:00:00'),

  (9, 4, 2, '2018-05-06 15:00:00'),
  (10, 4, 1, '2018-05-06 16:00:00'),

  (11, 5, 1, '2018-05-06 17:00:05'),
  (12, 5, 2, '2018-05-06 18:01:00'),
  (13, 5, 3, '2018-05-06 19:01:00'),
  (14, 5, 4, '2018-05-06 20:01:00'),
  (15, 5, 5, '2018-05-06 21:01:00'),

  (16, 6, 2, '2018-05-06 23:01:00'),
  (17, 6, 3, '2018-05-07 00:01:00'),
  (18, 6, 4, '2018-05-07 01:01:00'),
  (19, 6, 5, '2018-05-07 02:01:00'),
  (20, 6, 1, '2018-05-07 03:01:00');

-- Posts

INSERT INTO forum_posts(id, topic_id, author_id, content, likes_count, created_at, updated_at) VALUES
  (1, 1, 1, '<p>Сообщение 1.1</p>', 0, '2018-05-06 04:00:00', NULL),

  (2, 2, 1, '<p>Сообщение 2.1</p>', 0, '2018-05-06 05:00:00', NULL),
  (3, 2, 2, '<p>Сообщение 2.2</p>', 0, '2018-05-06 06:01:00', NULL),
  (4, 2, 3, '<p>Сообщение 2.3</p>', 0, '2018-05-06 07:01:00', NULL),

  (5, 3, 1, '<p>Сообщение 3.1</p>', 0, '2018-05-06 08:00:00', NULL),
  (6, 3, 2, '<p>Сообщение 3.2</p>', 0, '2018-05-06 09:01:00', NULL),
  (7, 3, 3, '<p>Сообщение 3.3</p>', 0, '2018-05-06 10:01:00', NULL),
  (8, 3, 4, '<p>Сообщение 3.4</p>', 0, '2018-05-06 11:01:00', NULL),

  (9, 4, 1, '<p>Сообщение 4.1</p>', 0, '2018-05-06 12:00:00', NULL),
  (10, 4, 2, '<p>Сообщение 4.2</p>', 0, '2018-05-06 13:01:00', NULL),
  (11, 4, 1, '<p>Сообщение 4.3</p>', 0, '2018-05-06 14:01:00', NULL),
  (12, 4, 2, '<p>Сообщение 4.4</p>', 0, '2018-05-06 15:01:00', NULL),
  (13, 4, 1, '<p>Сообщение 4.5</p>', 0, '2018-05-06 16:01:00', NULL),

  (14, 5, 1, '<p>Сообщение 5.1</p>', 0, '2018-05-06 17:00:00', NULL),
  (15, 5, 2, '<p>Сообщение 5.2</p>', 0, '2018-05-06 18:01:00', NULL),
  (16, 5, 3, '<p>Сообщение 5.3</p>', 0, '2018-05-06 19:01:00', NULL),
  (17, 5, 4, '<p>Сообщение 5.4</p>', 0, '2018-05-06 20:01:00', NULL),
  (18, 5, 5, '<p>Сообщение 5.5</p>', 0, '2018-05-06 21:01:00', NULL),

  (19, 6, 1, '<p>Сообщение 6.1</p>', 0, '2018-05-06 22:00:00', NULL),
  (20, 6, 2, '<p>Сообщение 6.2</p>', 0, '2018-05-06 23:01:00', NULL),
  (21, 6, 3, '<p>Сообщение 6.3</p>', 0, '2018-05-07 00:01:00', NULL),
  (22, 6, 4, '<p>Сообщение 6.4</p>', 0, '2018-05-07 01:01:00', NULL),
  (23, 6, 5, '<p>Сообщение 6.5</p>', 0, '2018-05-07 02:01:00', NULL),
  (24, 6, 1, '<p>Сообщение 6.6</p>', 0, '2018-05-07 03:01:00', NULL);
