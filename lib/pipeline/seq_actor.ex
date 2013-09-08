defmodule SeqActor do
  use ExActor
  import Workers
  
  defcast consume(i) do 
    a = f1(i) 
    b = f2(a)
    result = f3(b)

    result |> to_string |> IO.puts
  end
end