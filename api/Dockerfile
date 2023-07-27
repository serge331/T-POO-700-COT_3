FROM elixir:latest

RUN apt-get update
RUN apt-get install --yes build-essential inotify-tools postgresql-client

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs

RUN mkdir app
COPY . /app
WORKDIR /app

COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY mix.exs .
COPY mix.lock . 

RUN mix local.hex --force
RUN mix local.rebar --force 

RUN mix deps.get --force
RUN mix deps.compile
RUN mix phx.digest
RUN mix release

RUN npm install
RUN cd ..
RUN chmod +x entrypoint.sh

EXPOSE 4000

CMD ["./entrypoint.sh"]