defmodule Siris.Repo do
  use Ecto.Repo,
    otp_app: :siris,
    adapter: Ecto.Adapters.Postgres
end
