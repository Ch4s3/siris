import Config

secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
port = String.to_integer(System.get_env("PORT", "4000"))
scout_key = System.get_env("SCOUT_KEY")

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :siris, Siris.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

config :siris, SirisWeb.Endpoint,
  secret_key_base: secret_key_base,
  http: [:inet6, port: port]

config :scout_apm,
  key: scout_key
