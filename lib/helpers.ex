defmodule Helpers do
  def times(n, fun) when n > 0 do times(0, n, fun) end
  def times(n, n, _) do :ok end
  def times(i, n, fun) do fun.(i); times(i+1, n, fun) end
  
  defmacro defactor(name, [do: block]) do
    quote do
      defmodule unquote(name) do
        use ExActor, tupmod: true
        unquote(block)
      end
    end
  end
end