defmodule Gatexir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GatexirWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Gatexir.PubSub},
      # Start the Endpoint (http/https)
      GatexirWeb.Endpoint,
      Gatexir.Engine
      # Start a worker by calling: Gatexir.Worker.start_link(arg)
      # {Gatexir.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gatexir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GatexirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
