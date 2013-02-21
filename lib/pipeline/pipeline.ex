defmodule Pipeline do
  use ExActor

  defrecord PipelineInfo, [:job, :next]
  
  def init(desc) do
    initial_state(PipelineInfo.new(desc))
  end
  
  defcast consume(data), state: pipeline_info do
    result = pipeline_info.job.(data)
    consume_next(pipeline_info.next, result)
  end

  def consume_next(nil, _), do: :ok
  def consume_next(next, data) do
    next.consume(data)
  end

  def create(jobs) do
    List.foldr(jobs, nil, 
      fn(job, next) ->
        Pipeline.actor_start(job: job, next: next)
      end
    )
  end
end