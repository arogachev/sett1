BEGIN;
--
-- Create model Forum
--
CREATE TABLE "forum_forums" ("id" serial NOT NULL PRIMARY KEY, "name" varchar(255) NOT NULL, "description" varchar(255) NOT NULL, "image" varchar(255) NOT NULL, "topics_count" integer NOT NULL CHECK ("topics_count" >= 0), "posts_count" integer NOT NULL CHECK ("posts_count" >= 0), "created_at" timestamp with time zone NOT NULL, "parent_id" integer NULL);
--
-- Create model Post
--
CREATE TABLE "forum_posts" ("id" serial NOT NULL PRIMARY KEY, "content" text NOT NULL, "likes_count" integer NOT NULL CHECK ("likes_count" >= 0), "created_at" timestamp with time zone NOT NULL, "updated_at" timestamp with time zone NULL);
--
-- Create model PostLike
--
CREATE TABLE "forum_posts_likes" ("id" serial NOT NULL PRIMARY KEY, "liked_at" timestamp with time zone NOT NULL, "post_id" integer NOT NULL);
--
-- Create model Topic
--
CREATE TABLE "forum_topics" ("id" serial NOT NULL PRIMARY KEY, "name" varchar(255) NOT NULL, "description" varchar(255) NOT NULL, "image" varchar(255) NOT NULL, "posts_count" integer NOT NULL CHECK ("posts_count" >= 0), "participants_count" integer NOT NULL CHECK ("participants_count" >= 0), "views_count" integer NOT NULL CHECK ("views_count" >= 0), "pinned" boolean NOT NULL, "created_at" timestamp with time zone NOT NULL);
--
-- Create model TopicView
--
CREATE TABLE "forum_topics_views" ("id" serial NOT NULL PRIMARY KEY, "viewed_at" timestamp with time zone NOT NULL, "topic_id" integer NOT NULL);
--
-- Create model User
--
CREATE TABLE "forum_users" ("id" serial NOT NULL PRIMARY KEY, "email" varchar(254) NOT NULL UNIQUE, "password" varchar(128) NOT NULL, "name" varchar(255) NOT NULL, "joined_at" timestamp with time zone NOT NULL);
--
-- Create model UserProfile
--
CREATE TABLE "forum_users_profiles" ("id" serial NOT NULL PRIMARY KEY, "description" text NOT NULL, "avatar" varchar(255) NOT NULL, "location" varchar(255) NOT NULL, "born_at" date NULL, "user_id" integer NOT NULL);
--
-- Add field user to topicview
--
ALTER TABLE "forum_topics_views" ADD COLUMN "user_id" integer NOT NULL;
--
-- Add field author to topic
--
ALTER TABLE "forum_topics" ADD COLUMN "author_id" integer NOT NULL;
--
-- Add field forum to topic
--
ALTER TABLE "forum_topics" ADD COLUMN "forum_id" integer NOT NULL;
--
-- Add field user to postlike
--
ALTER TABLE "forum_posts_likes" ADD COLUMN "user_id" integer NOT NULL;
--
-- Add field author to post
--
ALTER TABLE "forum_posts" ADD COLUMN "author_id" integer NOT NULL;
--
-- Add field topic to post
--
ALTER TABLE "forum_posts" ADD COLUMN "topic_id" integer NOT NULL;
--
-- Alter unique_together for topicview (1 constraint(s))
--
ALTER TABLE "forum_topics_views" ADD CONSTRAINT forum_topics_views_topic_id_user_id_13d8d338_uniq UNIQUE ("topic_id", "user_id");
--
-- Alter unique_together for topic (1 constraint(s))
--
ALTER TABLE "forum_topics" ADD CONSTRAINT forum_topics_forum_id_name_ece5cd78_uniq UNIQUE ("forum_id", "name");
--
-- Alter unique_together for postlike (1 constraint(s))
--
ALTER TABLE "forum_posts_likes" ADD CONSTRAINT forum_posts_likes_post_id_user_id_363f824b_uniq UNIQUE ("post_id", "user_id");
--
-- Alter unique_together for forum (1 constraint(s))
--
ALTER TABLE "forum_forums" ADD CONSTRAINT forum_forums_parent_id_name_3ba2f6e4_uniq UNIQUE ("parent_id", "name");
ALTER TABLE "forum_forums" ADD CONSTRAINT "forum_forums_parent_id_694b2fdd_fk_forum_forums_id" FOREIGN KEY ("parent_id") REFERENCES "forum_forums" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_forums_parent_id_694b2fdd" ON "forum_forums" ("parent_id");
ALTER TABLE "forum_posts_likes" ADD CONSTRAINT "forum_posts_likes_post_id_70ad05ee_fk_forum_posts_id" FOREIGN KEY ("post_id") REFERENCES "forum_posts" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_posts_likes_post_id_70ad05ee" ON "forum_posts_likes" ("post_id");
ALTER TABLE "forum_topics_views" ADD CONSTRAINT "forum_topics_views_topic_id_fb2e2932_fk_forum_topics_id" FOREIGN KEY ("topic_id") REFERENCES "forum_topics" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_topics_views_topic_id_fb2e2932" ON "forum_topics_views" ("topic_id");
CREATE INDEX "forum_users_email_737ddaff_like" ON "forum_users" ("email" varchar_pattern_ops);
ALTER TABLE "forum_users_profiles" ADD CONSTRAINT "forum_users_profiles_user_id_b5cb7682_fk_forum_users_id" FOREIGN KEY ("user_id") REFERENCES "forum_users" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_users_profiles_user_id_b5cb7682" ON "forum_users_profiles" ("user_id");
CREATE INDEX "forum_topics_views_user_id_e1f9e55b" ON "forum_topics_views" ("user_id");
ALTER TABLE "forum_topics_views" ADD CONSTRAINT "forum_topics_views_user_id_e1f9e55b_fk_forum_users_id" FOREIGN KEY ("user_id") REFERENCES "forum_users" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_topics_author_id_ec6c347c" ON "forum_topics" ("author_id");
ALTER TABLE "forum_topics" ADD CONSTRAINT "forum_topics_author_id_ec6c347c_fk_forum_users_id" FOREIGN KEY ("author_id") REFERENCES "forum_users" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_topics_forum_id_879311c2" ON "forum_topics" ("forum_id");
ALTER TABLE "forum_topics" ADD CONSTRAINT "forum_topics_forum_id_879311c2_fk_forum_forums_id" FOREIGN KEY ("forum_id") REFERENCES "forum_forums" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_posts_likes_user_id_b9769c39" ON "forum_posts_likes" ("user_id");
ALTER TABLE "forum_posts_likes" ADD CONSTRAINT "forum_posts_likes_user_id_b9769c39_fk_forum_users_id" FOREIGN KEY ("user_id") REFERENCES "forum_users" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_posts_author_id_8e86e0c3" ON "forum_posts" ("author_id");
ALTER TABLE "forum_posts" ADD CONSTRAINT "forum_posts_author_id_8e86e0c3_fk_forum_users_id" FOREIGN KEY ("author_id") REFERENCES "forum_users" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "forum_posts_topic_id_05bebe35" ON "forum_posts" ("topic_id");
ALTER TABLE "forum_posts" ADD CONSTRAINT "forum_posts_topic_id_05bebe35_fk_forum_topics_id" FOREIGN KEY ("topic_id") REFERENCES "forum_topics" ("id") DEFERRABLE INITIALLY DEFERRED;
COMMIT;
