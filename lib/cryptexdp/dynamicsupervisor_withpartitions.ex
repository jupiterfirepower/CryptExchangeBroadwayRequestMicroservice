defmodule Cryptexdp.DynamicSupervisorWithPartition do
  use DynamicSupervisor
  alias Cryptexdp.RequestWorker

  def start_link(_init_arg) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_request_worker(urls) do
    spec = %{id: RequestWorker, start: {RequestWorker, :start_link, urls}}

    DynamicSupervisor.start_child(
      {:via, PartitionSupervisor, {__MODULE__, self()}},
      spec
    )
  end
end
