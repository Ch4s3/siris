FROM elixir:1.10.2-alpine AS build
ENV MIX_ENV=prod \
    LANG=C.UTF-8
RUN set -xe && apk add curl make --update-cache 
RUN apk add --update git build-base nodejs yarn python

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get
RUN mix deps.compile

# build assets
COPY assets/package.json assets/yarn.lock assets/
COPY assets assets
COPY priv priv
RUN cd assets && yarn install --pure-lockfile
RUN cd assets && yarn deploy
RUN mix phx.digest

# build project
COPY lib lib
RUN mix compile 

# build release (uncomment COPY if rel/ exists)
# COPY rel rel
RUN mix release

# prepare release image
FROM alpine:3.9 AS app
RUN apk add --update bash openssl

RUN mkdir /app
WORKDIR /app

COPY --from=build /app/_build/prod/rel/siris ./
RUN chown -R nobody: /app
USER nobody
CMD ["./bin/siris", "start"]
