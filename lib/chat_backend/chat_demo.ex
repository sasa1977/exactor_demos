require Objectify

Objectify.transform do
  defmodule ChatDemo do
    def run do
      {:ok, chatroom} = Chatroom.new
      
      {:ok, client1} = Client.new(1); client1.join(chatroom)
      {:ok, client2} = Client.new(2); client2.join(chatroom)
      {:ok, client3} = Client.new(3); client3.join(chatroom)
      
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
  end
end