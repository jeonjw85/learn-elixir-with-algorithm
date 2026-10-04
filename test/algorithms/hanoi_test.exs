defmodule Algorithms.HanoiTest do
  use ExUnit.Case, async: true

  alias Algorithms.Hanoi

  test "원판이 없으면 이동하지 않는다" do
    assert Hanoi.solve(0) == []
  end

  test "원판 하나를 A에서 C로 옮긴다" do
    assert Hanoi.solve(1) == [{1, "A", "C"}]
  end

  test "최소 이동 횟수로 규칙을 지키며 모든 원판을 C로 옮긴다" do
    for count <- 1..5 do
      disks = Enum.to_list(1..count)
      moves = Hanoi.solve(count)

      assert length(moves) == Integer.pow(2, count) - 1

      pegs =
        Enum.reduce(moves, %{"A" => disks, "B" => [], "C" => []}, fn
          {disk, from, to}, pegs ->
            assert [^disk | remaining] = Map.fetch!(pegs, from)
            target = Map.fetch!(pegs, to)
            assert target == [] or disk < hd(target)

            pegs
            |> Map.put(from, remaining)
            |> Map.put(to, [disk | target])
        end)

      assert pegs == %{"A" => [], "B" => [], "C" => disks}
    end
  end
end
