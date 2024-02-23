defmodule Cryptexdp.UrlProducer do
  @moduledoc """
  Cryptexdp.UrlProducer
  """
  use GenStage
  require Logger

  def start_link(_args) do
    GenStage.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(initial_state) do
    Logger.info("UrlProducer init.")
    {:producer, initial_state, buffer_size: :infinity}
  end

  def domain(url) do
    URI.parse(url).host
    |> String.split(".")
    |> Enum.take(-2)
    |> Enum.join(".")
  end

  def get_service_data_by_url(urls) when is_list(urls) do
    Logger.info("Cryptexdp.UrlProducer get_service_data_by_url(urls).")

    result = Enum.group_by(urls, & domain(&1))
             |> Enum.into([])
             |> Enum.map(fn {_, url_list} -> url_list end)

    Logger.info("Cryptexdp.UrlProducer get_service_data_by_url(urls), urls : #{inspect(result)}.")

    Cryptexdp.DataPipeline
    |> Broadway.producer_names()
    |> List.first()
    |> GenStage.cast({:urls, result})
  end

  def handle_demand(demand, state) do
    Logger.info("UrlProducer received demand for #{demand} urls.")
    {:noreply, [], state}
  end

  def handle_cast({:urls, urls}, state) do
    {:noreply, urls, state}
  end
end
