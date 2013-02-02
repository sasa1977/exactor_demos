import ExActor

defactor Calculator do
  defcast inc(x), state: value, do: new_state(value + x)
  defcast dec(x), state: value, do: new_state(value - x)
  defcall get, state: value, do: value
end