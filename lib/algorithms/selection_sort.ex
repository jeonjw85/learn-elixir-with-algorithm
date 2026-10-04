defmodule Algorithms.SelectionSort do
  def sort([]), do: []

  def sort([head | tail] = values) do
    smallest = minimum(tail, head)
    [smallest | sort(List.delete(values, smallest))]
  end

  defp minimum([], smallest), do: smallest

  defp minimum([head | tail], smallest) when head < smallest do
    minimum(tail, head)
  end

  defp minimum([_head | tail], smallest) do
    minimum(tail, smallest)
  end
end
