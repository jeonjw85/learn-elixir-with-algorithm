defmodule Algorithms.Fibonacci do
  def calculate(n) when is_integer(n) and n >= 0 do
    calculate(n, 0, 1)
  end

  defp calculate(0, current, _next), do: current

  defp calculate(n, current, next) do
    calculate(n - 1, next, current + next)
  end
end
