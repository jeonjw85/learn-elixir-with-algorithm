defmodule Algorithms.Hanoi do
  def solve(disks) when is_integer(disks) and disks >= 0 do
    move(disks, "A", "C", "B")
  end

  defp move(0, _from, _to, _auxiliary), do: []

  defp move(disks, from, to, auxiliary) do
    move(disks - 1, from, auxiliary, to) ++
      [{disks, from, to}] ++ move(disks - 1, auxiliary, to, from)
  end
end
