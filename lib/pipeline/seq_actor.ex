defmodule SeqActor do
  use ExActor
  import Workers
  
  defcast consume(i) do 
    a = f1(i) 
    b = f2(a)
    result = f3(b)
    IO.puts result
  end
end