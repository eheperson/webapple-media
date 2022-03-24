# Webapple

**Template repository for the dockerized django apps based on postgresql, gunicorn, nginx..**

> `/app/main` directory created by `'$ django-admin startproject main'` command. You can use this project as your main project or just remove it and create new one.

> Default admin user is : `username: 'admin', password: '123456@@' ` for the django admin panel. 
___
## Preparing : 

0. Clone the repo
1. Copy `env.txt` to `app/.env`
2. Change the specific fields in `app/.env`

## Start Development Server : 

```
#Start services at background
$ docker-compose -f docker-compose.yml up -d --build

#Watch the logh through development
$ docker-compose -f docker-compose.yml logs -f
```
**One Shot Command :** `docker-compose -f docker-compose.yml up -d --build; docker-compose -f docker-compose.yml logs -f`

## Build Up Production

```

$ docker-compose -f docker-compose.prod.yml up -d --build

# The steps below not required since them allready included to entrypoint.prod.sh
$ docker-compose -f docker-compose.prod.yml exec webapple-app python manage.py migrate --noinput
$ docker-compose -f docker-compose.prod.yml exec webapple-app python manage.py collectstatic --no-input --clear

# verify in the logs
$ docker-compose -f docker-compose.prod.yml logs -f

```

> Request to `http://localhost:1337/static/*` will be served from the "staticfiles"

> Navigate to `http://localhost:1337/admin` and ensure the static assets load correctly.

## Usefull Commands


```
# You can check that the volume was created as well by running:
    $ docker volume inspect webapple_postgresql_data
```

```
# Run migrations manually : 
    $ docker-compose exec web python manage.py flush --no-input
    $ docker-compose exec web python manage.py migrate
```


```
# Spin down the development containers: 
    $ docker-compose down -v
```

```
# Bring the containers once done: 
    $ docker-compose -f docker-compose.prod.yml down -v
```



