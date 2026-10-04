defmodule Algorithms.LinearSearch do
  def find(values, target) do
    find(values, target, 0)
  end

  defp find([], _target, _index), do: nil
  defp find([target | _rest], target, index), do: index

  defp find([_value | rest], target, index) do
    find(rest, target, index + 1)
  end
end
