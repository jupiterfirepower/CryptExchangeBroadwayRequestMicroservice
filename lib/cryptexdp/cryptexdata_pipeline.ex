defmodule Cryptexdp.DataPipeline do
  @moduledoc """
  Cryptexdp.DataPipeline
  """
  use Broadway
  require Logger

  def start_link(_args) do
    options = [
      name: Cryptexdp.DataPipeline,
      producer: [
        module: {Cryptexdp.UrlProducer, []},
        transformer: {Cryptexdp.DataPipeline, :transform, []}
      ],
      processors: [
        default: [max_demand: 1, concurrency: 2]
      ],
      batchers: [
        default: [batch_size: 1, concurrency: 2]
      ]
    ]

    Broadway.start_link(__MODULE__, options)
  end

  def transform(event, _options) do
    %Broadway.Message{
      data: event,
      acknowledger: {Cryptexdp.DataPipeline, :urls, []}
    }
  end

  def ack(:urls, _successful, _failed) do
    :ok
  end

  def domain(url) do
    URI.parse(url).host
    |> String.split(".")
    |> Enum.take(-2)
    |> Enum.join(".")
  end

  def handle_message(_processor, message, _context) do
    Logger.info("Handle Message received #{inspect(message)}")
    Broadway.Message.put_batch_key(message, domain(hd message.data))
  end

  #def handle_batch(_batcher, [message], _batch_info, _context) do
  #  Logger.info("Batch Processor received #{message.data}")
  #  Cryptexdp.DynamicSupervisorWithPartition.start_request_worker([message.data])
    # Scraper.work()
  #  [message]
  #end

  def handle_batch(_batcher, messages, _batch_info, _context) do
    urls = Enum.map(messages, fn m -> m.data end) #|> List.flatten
    Logger.info("Batch Processor received urls count: #{length(urls)}, links: #{inspect(urls)}")
    Task.start_link(fn ->
      Cryptexdp.DynamicSupervisorWithPartition.start_request_worker(urls)
    end)
    messages
  end
end
