# sett1

## Database schema

```
python manage.py migrate --fake forum zero
python manage.py makemigrations forum
python manage.py sqlmigrate forum 0001_initial > forum/sql/schema.sql
```
