import ExActor
require Objectify

Objectify.transform do
  defrecord ClientInfo, id: nil, chatroom: nil
  actor Client do
    def init(id) do initial_state(ClientInfo.new(id: id)) end
  
    defcast join(chatroom), state: client_info do
      chatroom.add_client(this)
      new_state(client_info.chatroom(chatroom))
    end
    
    defcast send(_message), state: ClientInfo[chatroom: nil] do
      :ok
    end
    
    defcast send(message), state: client_info do
      client_info.chatroom.send(this, {client_info.id, message})
    end
  
    defcast notify({from, message}), state: client_info do
      # Calling Erlang's IO function because it behaves better than Elixir's when
      # used concurrently from multiple processes.
      :io.format("~s", ["<<#{client_info.id}>>: client #{from} says #{message}\n"])
    end
  end
end