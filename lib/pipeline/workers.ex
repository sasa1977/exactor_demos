defmodule Workers do
  def f1(i) do 
    :timer.sleep(100)
    i + 1
  end
  
  def f2(i) do 
    :timer.sleep(100)
    i * 2
  end
  
  def f3(i) do
    :timer.sleep(100)
    i - 3
  end
end
