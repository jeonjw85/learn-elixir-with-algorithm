defmodule Algorithms.InsertionSort do
  def sort(values) do
    Enum.reduce(values, [], &insert/2)
  end

  defp insert(value, []), do: [value]

  defp insert(value, [head | _tail] = values) when value <= head do
    [value | values]
  end

  defp insert(value, [head | tail]) do
    [head | insert(value, tail)]
  end
end
