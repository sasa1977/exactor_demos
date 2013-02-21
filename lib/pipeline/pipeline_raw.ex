defmodule Pipeline1 do
  use ExActor
  import Workers
  
  def init(_) do
    initial_state(Pipeline2.actor_start)
  end
  
  defcast consume(data), state: actor2 do
  	actor2.consume(f1(data))
  end
end

defmodule Pipeline2 do
  use ExActor
  import Workers

  def init(_) do
    initial_state(Pipeline3.actor_start)
  end
  
  defcast consume(data), state: actor3 do
    actor3.consume(f2(data))
  end
end

defmodule Pipeline3 do
  use ExActor
  import Workers

  defcast consume(data) do
    IO.puts(f3(data))
  end
end

defmodule PipelineRaw do
  def run do
    pipeline = Pipeline1.actor_start
    Enum.each(1..10, fn(i) -> pipeline.consume(i) end)
    :timer.sleep(1000)
  end
end