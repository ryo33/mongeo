defmodule Border do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Border.Endpoint, []),
      worker(Border.Rooms, [])
    ]

    opts = [strategy: :one_for_one, name: Border.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Border.Endpoint.config_change(changed, removed)
    :ok
  end
end
