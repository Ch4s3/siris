# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :scout_apm,
  name: "Siis-Brewing",
  monitor: true

config :siris,
  ecto_repos: [Siris.Repo]

# Configures the endpoint
config :siris, SirisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JVVB6lq3SSxQJwC+lUJn7zEE8c2PUYtmL/p/0FFPTPG1gYgYKZ2wFzxh70rgAn/5",
  render_errors: [view: SirisWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Siris.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "q7+3RL77jq6mKA5okFgkgCFjnUMdespt"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
