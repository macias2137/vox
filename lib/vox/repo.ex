defmodule Vox.Repo do
  use Ecto.Repo,
    otp_app: :vox,
    adapter: Ecto.Adapters.Postgres
end
