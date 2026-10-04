defmodule Algorithms.BinarySearch do
  def find(values, target) do
    values
    |> List.to_tuple()
    |> search(target, 0, length(values) - 1)
  end

  defp search(_values, _target, low, high) when low > high, do: nil

  defp search(values, target, low, high) do
    middle = div(low + high, 2)
    value = elem(values, middle)

    cond do
      value < target -> search(values, target, middle + 1, high)
      value > target -> search(values, target, low, middle - 1)
      true -> middle
    end
  end
end
