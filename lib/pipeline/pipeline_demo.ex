defmodule PipelineDemo do
  def run do
    test_seq()
    test_pipeline()
  end
  
  defp test_seq do
    IO.puts "sequential version"
    send_test_messages(SeqActor.actor_start)
    :timer.sleep(4000)
    IO.puts "\n"
  end
  
  import Workers
  defp test_pipeline do
    IO.puts "pipeline"
    pipeline = Pipeline.create([
      function(f1/1),
      function(f2/1),
      function(f3/1),
      fn(x) -> IO.puts x end
    ])
    
    send_test_messages(pipeline)
    :timer.sleep(2000)
    IO.puts "\n"
  end
  
  defp send_test_messages(target) do
    Enum.each(1..10, fn(i) -> target.consume(i) end)
  end
end