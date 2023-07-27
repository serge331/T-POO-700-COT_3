#!/bin/bash
while ! pg_isready -q -h $PGHOST -p $PGPORT --username=$PGUSER
do
  echo "$(date) - waiting database to start"
  sleep 2
done

if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
  echo "Database $PGDATABASE does not exist. Creating..."
  createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
  mix ecto.migrate
  mix run priv/repo/seeds.exs
  echo "Database $PGDATABASE created."
else
  source .env
  if [[ $RESETDB == 1 ]]; then
    echo "Database $PGDATABASE is being reseted becauge you have specified RESETDB !! "
    mix ecto.reset
    echo "Database $PGDATABASE reseted !"
    export RESETDB=0
  else
    mix ecto.migrate
  fi
fi
echo "RUNNING API SERVER PHOENIX || LET'S GET READY TO RUMBLE !!"
exec mix phx.server