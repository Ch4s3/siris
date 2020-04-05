FROM elixir:1.10.2-alpine AS compile_phase
ENV MIX_ENV=prod \
    LANG=C.UTF-8
RUN set -xe && apk add curl make --update-cache 

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Create the application build directory
RUN mkdir /app
WORKDIR /app

# Copy over all the necessary application files and directories
COPY config ./config
COPY lib ./lib
COPY mix.exs .
COPY mix.lock .

# Fetch the application dependencies and build the application
RUN mix deps.get
RUN mix deps.compile

From node:13.12.0-alpine3.11 as node_builder
RUN apk add --update git build-base  yarn  python
COPY priv ./priv
COPY assets assets
COPY priv ./priv
RUN cd assets && yarn && yarn deploy

FROM compile_phase AS app_builder
COPY --from=node_builder /app/priv ./priv
RUN mix phx.digest
RUN mix release

FROM alpine AS app
ENV LANG=C.UTF-8
# Install openssl
RUN apk update && apk add openssl ncurses-libs
# Copy over the build artifact from the previous step and create a non root user
RUN adduser -h /home/app -D app
WORKDIR /home/app
COPY --from=app_builder /app/_build .
RUN chown -R app: ./prod
USER app
CMD ["./prod/rel/siris//bin/siris", "start"]