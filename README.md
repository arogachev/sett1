# sett1

## Queries

Queries can be found in the [forum/sql] folder.

### Database schema

```
python manage.py migrate --fake forum zero
python manage.py makemigrations forum
python manage.py sqlmigrate forum 0001_initial > forum/sql/schema.sql
```
[forum/sql]: https://github.com/arogachev/sett1/tree/master/forum/sql
