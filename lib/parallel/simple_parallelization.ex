defmodule SimpleParallelization do
  def square(x) do
    :timer.sleep(100)
    x * x
  end
  
  def parallel_squares(numbers) do
    Enum.each(numbers, fn(x) ->
      spawn(fn() ->
        IO.puts "#{x} * #{x} = #{square(x)}"
      end)
    end)
  end
end