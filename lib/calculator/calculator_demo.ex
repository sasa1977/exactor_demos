defmodule CalculatorDemo do
  def run do    
    calculator = Calculator.actor_start(0)
    calculator.inc(10)
    calculator.dec(5)

    calculator.get
    |> to_string
    |> IO.puts
  end
end