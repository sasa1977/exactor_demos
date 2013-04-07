defmodule ParallelizationDemo do
  def run do
    IO.puts "simple"
    SimpleParallelization.parallel_squares(1..10)
    :timer.sleep(200)
    
    IO.puts "\npool"
    PoolSquare.parallel_squares(PoolSquare.start_pool, 1..10)
    :timer.sleep(300)
    
    IO.puts "\nresponses"
    IO.inspect ResponsesSquares.parallel_squares(1..10)
  end
end