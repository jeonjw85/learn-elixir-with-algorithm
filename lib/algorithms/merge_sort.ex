defmodule Algorithms.MergeSort do
  def sort([]), do: []
  def sort([value]), do: [value]

  def sort(values) do
    {left, right} = Enum.split(values, div(length(values), 2))
    merge(sort(left), sort(right))
  end

  defp merge([], right), do: right
  defp merge(left, []), do: left

  defp merge([left | left_rest], [right | _right_rest] = right_values)
       when left <= right do
    [left | merge(left_rest, right_values)]
  end

  defp merge(left_values, [right | right_rest]) do
    [right | merge(left_values, right_rest)]
  end
end
