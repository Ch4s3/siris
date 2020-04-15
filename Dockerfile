FROM elixir:1.10.2-alpine AS build
ENV MIX_ENV=prod \
    LANG=C.UTF-8
RUN set -xe && apk add curl make --update-cache 
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

FROM node:13.12.0-alpine3.11 AS assets-builder
RUN apk add --update git build-base python
# build assets
RUN mkdir /assets
WORKDIR /app
COPY assets/package.json ./
COPY assets/yarn.lock ./
COPY assets/bsconfig.json ./
COPY assets ./
COPY priv priv

RUN yarn install --pure-lockfile && yarn deploy


FROM elixir:1.10.2-alpine AS release-phase
COPY --from=build app app
COPY --from=build /root/.mix /root/.mix 
COPY --from=assets-builder /priv /app/priv
WORKDIR /app
ENV MIX_ENV=prod

RUN mix phx.digest

# build project
COPY lib lib
RUN mix compile 

RUN mix release

FROM alpine:3.9 AS app
RUN apk add --update bash openssl

RUN mkdir /app
WORKDIR /app

COPY --from=release-phase /app/_build/prod/rel/siris ./
RUN chown -R nobody: /app
USER nobody
CMD ["./bin/siris", "start"]
