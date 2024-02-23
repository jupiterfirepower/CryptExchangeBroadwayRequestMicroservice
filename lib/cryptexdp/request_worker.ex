defmodule Cryptexdp.RequestWorker do
  @moduledoc """
  Cermicros.WorkConsumer
  """

  alias Cryptexdp.HttpHelper, as: ApiHelper
  require Logger

  def start_link(list) do
    #Logger.info("#{inspect(self())} RequestWorker received, urls: #{inspect(list)}")

    Task.start_link(fn ->
      Logger.info("#{inspect(self())} RequestWorker received, urls count: #{length(list)} #{inspect(list)}")
      _ = ApiHelper.call_apis_async(list)
      # send to kafka.
    end)

  end
end
