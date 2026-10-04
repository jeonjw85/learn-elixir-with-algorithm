defmodule Algorithms.Gcd do
  def calculate(left, right) when is_integer(left) and is_integer(right) do
    euclid(abs(left), abs(right))
  end

  defp euclid(left, 0), do: left

  defp euclid(left, right) do
    euclid(right, rem(left, right))
  end
end
