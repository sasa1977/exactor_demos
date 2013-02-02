import ExActor

defactor Producer do
  defcast produce, state: consumer do
    :timer.sleep(100)
    value = :random.uniform(100)
    consumer.consume(value)
    IO.puts "produced #{value}"
  end
end

defactor Consumer do
  defcast consume(value) do
    :timer.sleep(200)
    IO.puts "                consumed #{value}"
  end
end

defmodule ConsumerProducerDemo do
  import Helpers
  
  def run do
    {:ok, consumer} = Consumer.start
    {:ok, producer} = Producer.start(consumer)
    
    times(5, fn(_) -> producer.produce end)
    
    IO.puts "main process finished\n"
    :timer.sleep(2000)
  end
end