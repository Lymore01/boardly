defmodule Boardly.Repo do
  use Ecto.Repo,
    otp_app: :boardly,
    adapter: Ecto.Adapters.Postgres
end
