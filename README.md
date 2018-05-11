# sett1

## Queries

Queries can be found in the [forum/sql] folder.

### Generating database schema

1. Update migration:

```
python manage.py migrate --fake forum zero
rm forum/migrations/0001_initial.py
python manage.py makemigrations forum
```

2. Drop forum tables.

3. Apply new migration and save schema's SQL:

```
python manage.py migrate forum
python manage.py sqlmigrate forum 0001_initial > forum/sql/schema.sql
```
[forum/sql]: https://github.com/arogachev/sett1/tree/master/forum/sql
