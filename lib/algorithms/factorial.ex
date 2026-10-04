defmodule Algorithms.Factorial do
  def calculate(n) when is_integer(n) and n >= 0 do
    calculate(n, 1)
  end

  defp calculate(0, result), do: result

  defp calculate(n, result) do
    calculate(n - 1, n * result)
  end
end
