defmodule Chatroom do
  use ExActor

  def init(_) do initial_state([]) end

  defcast add_client(new_client), state: clients do 
    new_state([new_client | clients])
  end

  defcast send(sender, message), state: clients do
    Enum.each(clients, fn(client) ->
      if client != sender, do: client.notify(message)
    end)
  end
end