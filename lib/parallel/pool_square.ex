defmodule SquareActor do
  use ExActor
  
  defcall square(x) do
    :timer.sleep(100)
    IO.puts "#{x} * #{x} = #{x * x}"
  end
end

defmodule PoolSquare do
  def start_pool do
    {:ok, pool} = :poolboy.start(
      worker_module: SquareActor, size: 0, max_overflow: 5
    )
    
    pool
  end
  
  def parallel_squares(pool, numbers) do
    Enum.each(numbers, fn(x) ->
      spawn(fn() -> pooled_square(pool, x) end)
    end)
  end
  
  def pooled_square(pool, x) do
    :poolboy.transaction(pool, fn(pid) ->
      SquareActor.square(pid, x)
    end)
  end
end
