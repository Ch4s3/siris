import Config

secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
application_port = System.fetch_env!("APP_PORT")

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
  http: [:inet6, port: String.to_integer(application_port)],
  secret_key_base: secret_key_base
