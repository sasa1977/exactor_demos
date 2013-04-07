defmodule ParallelExec do
  def run(funs) do
    start_jobs(funs)
    collect_responses(length(funs))
  end

  defp start_jobs(funs) do
    caller = self
    Enum.each(funs, fn(fun) ->
      spawn(fn() ->
        execute_job(caller, fun)
      end)
    end)
  end
  
  defp execute_job(caller, fun) do
    response = fun.()
    caller <- {:response, response}
  end

  defp collect_responses(expected) do
    Enum.map(1..expected, fn(_) ->
      get_response
    end)
  end

  defp get_response do
    receive do
      {:response, response} -> response
    end
  end
end

defmodule ResponsesSquares do
  def parallel_squares(numbers) do
    ParallelExec.run(make_jobs(numbers))
  end
  
  defp make_jobs(numbers) do
    Enum.map(numbers, fn(x) ->
      fn() -> square(x) end
    end)
  end
  
  defp square(x) do
    :timer.sleep(100)
    {x, x * x}
  end
end