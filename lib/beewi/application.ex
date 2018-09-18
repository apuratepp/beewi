defmodule Beewi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Beewi.Worker.start_link(arg)
      # {Beewi.Worker, arg},
      %{
        id: :bifrost,
        start: { :bifrost, :start_link, [Beewi, [{:port, 2121}, {:ip_address, {0,0,0,0}}]] },
       }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Beewi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
