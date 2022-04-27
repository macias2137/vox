defmodule Vox.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Vox.Repo,
      # Start the Telemetry supervisor
      VoxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Vox.PubSub},
      # Start the Endpoint (http/https)
      VoxWeb.Endpoint
      # Start a worker by calling: Vox.Worker.start_link(arg)
      # {Vox.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Vox.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VoxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
