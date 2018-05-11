-- Schema

CREATE TABLE "forum_forums" ("id" serial NOT NULL PRIMARY KEY, "name" varchar(255) NOT NULL, "description" varchar(255) NOT NULL, "image" varchar(255) NOT NULL, "topics_count" integer NOT NULL CHECK ("topics_count" >= 0), "posts_count" integer NOT NULL CHECK ("posts_count" >= 0), "created_at" timestamp with time zone NOT NULL, "parent_id" integer NULL);
CREATE TABLE "forum_posts" ("id" serial NOT NULL PRIMARY KEY, "content" text NOT NULL, "likes_count" integer NOT NULL CHECK ("likes_count" >= 0), "created_at" timestamp with time zone NOT NULL, "updated_at" timestamp with time zone NULL);
CREATE TABLE "forum_topics" ("id" serial NOT NULL PRIMARY KEY, "name" varchar(255) NOT NULL, "description" varchar(255) NOT NULL, "image" varchar(255) NOT NULL, "posts_count" integer NOT NULL CHECK ("posts_count" >= 0), "participants_count" integer NOT NULL CHECK ("participants_count" >= 0), "views_count" integer NOT NULL CHECK ("views_count" >= 0), "pinned" boolean NOT NULL, "created_at" timestamp with time zone NOT NULL);
CREATE TABLE "forum_users" ("id" serial NOT NULL PRIMARY KEY, "email" varchar(254) NOT NULL UNIQUE, "password" varchar(128) NOT NULL, "name" varchar(255) NOT NULL, "joined_at" timestamp with time zone NOT NULL);
ALTER TABLE "forum_topics" ADD COLUMN "author_id" integer NOT NULL;
ALTER TABLE "forum_topics" ADD COLUMN "forum_id" integer NOT NULL;
ALTER TABLE "forum_posts" ADD COLUMN "author_id" integer NOT NULL;
ALTER TABLE "forum_posts" ADD COLUMN "topic_id" integer NOT NULL;
CREATE INDEX "forum_topic_partici_3e9be8_idx" ON "forum_topics" ("participants_count");
ALTER TABLE "forum_topics" ADD CONSTRAINT forum_topics_forum_id_name_ece5cd78_uniq UNIQUE ("forum_id", "name");
ALTER TABLE "forum_forums" ADD CONSTRAINT forum_forums_parent_id_name_3ba2f6e4_uniq UNIQUE ("parent_id", "name");
ALTER TABLE "forum_forums" ADD CONSTRAINT "forum_forums_parent_id_694b2fdd_fk_forum_forums_id" FOREIGN KEY ("parent_id") REFERENCES "forum_forums" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_forums_parent_id_694b2fdd" ON "forum_forums" ("parent_id");
CREATE INDEX "forum_users_email_737ddaff_like" ON "forum_users" ("email" varchar_pattern_ops);
CREATE INDEX "forum_topics_author_id_ec6c347c" ON "forum_topics" ("author_id");
ALTER TABLE "forum_topics" ADD CONSTRAINT "forum_topics_author_id_ec6c347c_fk_forum_users_id" FOREIGN KEY ("author_id") REFERENCES "forum_users" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_topics_forum_id_879311c2" ON "forum_topics" ("forum_id");
ALTER TABLE "forum_topics" ADD CONSTRAINT "forum_topics_forum_id_879311c2_fk_forum_forums_id" FOREIGN KEY ("forum_id") REFERENCES "forum_forums" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_posts_author_id_8e86e0c3" ON "forum_posts" ("author_id");
ALTER TABLE "forum_posts" ADD CONSTRAINT "forum_posts_author_id_8e86e0c3_fk_forum_users_id" FOREIGN KEY ("author_id") REFERENCES "forum_users" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_posts_topic_id_05bebe35" ON "forum_posts" ("topic_id");
ALTER TABLE "forum_posts" ADD CONSTRAINT "forum_posts_topic_id_05bebe35_fk_forum_topics_id" FOREIGN KEY ("topic_id") REFERENCES "forum_topics" ("id") DEFERRABLE INITIALLY DEFERRED;

-- Seeds

INSERT INTO forum_users (id, email, password, name, joined_at) VALUES
  (1, 'mivanov@example.com', 'pbkdf2_sha256$24000$NiGtvdzxWkOI$LI2cy7OBuW1OewPWJmeMZMh0J85dn3HWFNN6FOBuNe4=', 'Матвей Иванов', '2018-05-05 15:00:00'),
  (2, 'asmirnov@example.com', 'pbkdf2_sha256$24000$lv1eo2EBHj5p$pNaCB7VxsI586+o17o19L+TYzl+w4skDL5i80SeqnoA=', 'Артём Смирнов', '2018-05-05 16:00:00'),
  (3, 'mkuznecov@example.com', 'pbkdf2_sha256$24000$rV7Uivc23wuW$9dia86Q19r7irzyn9dre6b74bX2GNBx0sIBnrxN7l0Q=', 'Максим Кузнецов', '2018-05-05 17:00:00'),
  (4, 'dpopov@example.com', 'pbkdf2_sha256$24000$BoH2IXxaPRB6$HyWSdvnIEnyF9BWSiIvsQ8hPuf9vAG1ueB7zdfLOBFQ=', 'Дмитрий Попов', '2018-05-05 18:00:00'),
  (5, 'vosipov@example.com', 'pbkdf2_sha256$100000$c89MygBqMX9y$FfT+HBCRMwuizVrzYCGpVthO1DUuWF0Q4oLbkaGtQyA=', 'Владимир Осипов', '2018-05-05 19:00:00');
INSERT INTO forum_forums(id, parent_id, name, description, image, topics_count, posts_count, created_at) VALUES
  (1, NULL, 'Главный форум', '', '', 6, 24, '2018-05-05 20:00:00'),
  (2, 1, 'Общие вопросы', '', '', 6, 24, '2018-05-05 21:00:00');
INSERT INTO forum_topics(id, forum_id, author_id, name, description, image, posts_count, participants_count, views_count, pinned, created_at) VALUES
  (1, 1, 1, 'Тема 1 (1 сообщение, 1 пользователь)', '', '', 1, 1, 1, FALSE, '2018-05-05 22:00:00'),
  (2, 1, 2, 'Тема 2 (3 сообщения, 3 пользователя)', '', '', 3, 3, 3, FALSE, '2018-05-05 23:00:00'),
  (3, 1, 3, 'Тема 3 (4 сообщения, 4 пользователя)', '', '', 4, 4, 4, FALSE, '2018-05-06 00:00:00'),
  (4, 1, 4, 'Тема 4 (5 сообщений, 2 пользователя)', '', '', 5, 2, 5, FALSE, '2018-05-06 01:00:00'),
  (5, 1, 5, 'Тема 5 (5 сообщений, 5 пользователей)', '', '', 5, 5, 5, FALSE, '2018-05-06 02:00:00'),
  (6, 1, 1, 'Тема 6 (6 сообщений, 5 пользователей)', '', '', 6, 5, 6, FALSE, '2018-05-06 03:00:00');
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
