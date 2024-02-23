defmodule Cryptexdp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Cryptexdp.DataPipeline,
      #Cryptexdp.DynamicSupervisorWithPartition,
      {PartitionSupervisor,
        child_spec: DynamicSupervisor,
        name: Cryptexdp.DynamicSupervisorWithPartition},
      Cryptexdp.Scheduler,
      # Starts a worker by calling: Cryptexdp.Worker.start_link(arg)
      # {Cryptexdp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cryptexdp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
