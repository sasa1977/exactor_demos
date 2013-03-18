defmodule Queue do
  use ExActor

  defrecord State, worker: nil, worker_busy: false, messages: []

  def init(_) do
    initial_state(State.new(worker: Worker.actor_start(this)))
  end

  defcast worker_finished, state: state do
    state.worker_busy(false) |>
    maybe_notify_worker |>
    new_state
  end

  defcast push(msg), state: state do
    queue_message(state, msg) |>
    maybe_notify_worker |>
    new_state
  end

  defp queue_message(state, msg) do
    state.update_messages(fn(messages) -> [msg | messages] end)
  end

  defp maybe_notify_worker(State[worker_busy: false, messages: [_|_]] = state) do
    state.worker.process(Enum.reverse(state.messages))
    state.update(worker_busy: true, messages: [])
  end
  
  defp maybe_notify_worker(state), do: state
end

defmodule Job do
  def handle(messages) do
    :timer.sleep(100)
    IO.puts Enum.join(messages, ", ")
  end
end

defmodule Worker do
  use ExActor
  import Job

  defcast process(messages), state: queue do
    handle(messages)
    queue.worker_finished
  end
end

defmodule QueueingDemo do
  def run do
    run_seq
    run_queued
  end

  import Job
  defp run_seq do
    IO.puts "sequential:"
    Enum.each(1..10, fn(i) -> handle([i]) end)
    IO.puts "\n"
  end

  defp run_queued do
    IO.puts "queue:"
    queue = Queue.actor_start
    
    Enum.each(1..10, fn(i) ->
      queue.push(i)
      :timer.sleep(30)
    end)

    :timer.sleep(500)
  end  
end