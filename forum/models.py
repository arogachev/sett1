from django.db import models


class User(models.Model):
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=128)
    joined_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'forum_users'


class UserProfile(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=255, default='')
    description = models.TextField(default='')
    avatar = models.URLField(max_length=255, default='')
    location = models.CharField(max_length=255, default='')
    born_at = models.DateField(null=True)

    class Meta:
        db_table = 'forum_users_profiles'


class Forum(models.Model):
    parent = models.ForeignKey('self', null=True, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    description = models.CharField(max_length=255, default='')
    image = models.URLField(max_length=255, default='')
    topics_count = models.PositiveIntegerField(default=0)
    posts_count = models.PositiveIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'forum_forums'
        unique_together = ('parent', 'name')


class Topic(models.Model):
    forum = models.ForeignKey(Forum, on_delete=models.CASCADE)
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    description = models.CharField(max_length=255, default='')
    image = models.URLField(max_length=255, default='')
    posts_count = models.PositiveIntegerField(default=0)
    participants_count = models.PositiveIntegerField(default=0)
    views_count = models.PositiveIntegerField(default=0)
    pinned = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'forum_topics'
        unique_together = ('forum', 'name')


class TopicView(models.Model):
    topic = models.ForeignKey(Topic, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    viewed_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'forum_topics_views'
        unique_together = ('topic', 'user')


class Post(models.Model):
    topic = models.ForeignKey(Topic, on_delete=models.CASCADE)
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    content = models.TextField()
    likes_count = models.PositiveIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(null=True)

    class Meta:
        db_table = 'forum_posts'


class PostLike(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    liked_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'forum_posts_likes'
        unique_together = ('post', 'user')
