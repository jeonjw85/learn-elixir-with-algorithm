defmodule Algorithms.BubbleSort do
  def sort(values) do
    case bubble(values) do
      {values, false} -> values
      {values, true} -> sort(values)
    end
  end

  defp bubble([]), do: {[], false}
  defp bubble([value]), do: {[value], false}

  defp bubble([left, right | rest]) when left > right do
    {values, _swapped} = bubble([left | rest])
    {[right | values], true}
  end

  defp bubble([left, right | rest]) do
    {values, swapped} = bubble([right | rest])
    {[left | values], swapped}
  end
end
