defmodule Algorithms.Prime do
  def prime?(n) when is_integer(n) and n < 2, do: false
  def prime?(2), do: true
  def prime?(n) when is_integer(n) and rem(n, 2) == 0, do: false

  def prime?(n) when is_integer(n) do
    check_divisor(n, 3)
  end

  defp check_divisor(n, divisor) when divisor * divisor > n, do: true
  defp check_divisor(n, divisor) when rem(n, divisor) == 0, do: false

  defp check_divisor(n, divisor) do
    check_divisor(n, divisor + 2)
  end
end
