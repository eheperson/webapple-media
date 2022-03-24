#!/bin/sh

# entrypoint.sh file  : 
#    to verify that Postgres is healthy before applying the migrations 
#    and running the Django development server

if [ "$DATABASE" = "postgres" ]
then
    # check if postgre container is healthy
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
    python manage.py collectstatic --noinput
    python manage.py flush --no-input
    python manage.py migrate --noinput
    python manage.py createsuperuser --username "$DJANGO_SUPERUSER_NAME" --no-input --email "$DJANGO_SUPER_USER_EMAIL" 
fi



exec "$@"
