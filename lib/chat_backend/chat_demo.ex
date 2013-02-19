defmodule ChatDemo do
  def run do
    [client1, client2, _] = create_clients(3, Chatroom.actor_start)
    
    # Since joining is async, I have to wait some time for it to take effect,
    # otherwise sending will not do anything. In a real production system,
    # these sleeps are not needed. They are here merely to "synchronize"
    # actions in order to get nice IO output.
    :timer.sleep(100)
    
    client1.send("Hi")
    :timer.sleep(100)
    
    client2.send("Hello")
    :timer.sleep(100)
  end

  defp create_clients(n, chatroom) do
    Enum.map((1..n), 
      fn(id) -> create_client(id, chatroom) end
    )
  end

  defp create_client(id, chatroom) do
    client1 = Client.actor_start(id)
    client1.join(chatroom)
  end
end