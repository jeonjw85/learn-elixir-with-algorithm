defmodule Algorithms.SortingTest do
  use ExUnit.Case, async: true

  @sorters [
    Algorithms.SelectionSort,
    Algorithms.BubbleSort,
    Algorithms.InsertionSort,
    Algorithms.MergeSort,
    Algorithms.QuickSort
  ]

  test "빈 목록과 원소 하나를 정렬한다" do
    for sorter <- @sorters, values <- [[], [5]] do
      assert sorter.sort(values) == values
    end
  end

  test "정렬된 목록, 역순, 중복 값, 음수를 정렬한다" do
    inputs = [
      [1, 2, 3, 4, 5],
      [5, 4, 3, 2, 1],
      [3, -1, 2, 3, 0, -1],
      [2, 2, 2, 2],
      [65, 66, 64]
    ]

    for sorter <- @sorters, values <- inputs do
      assert sorter.sort(values) == Enum.sort(values), inspect(sorter)
    end
  end

  test "작은 정수의 모든 조합을 정렬하고 원소 개수를 보존한다" do
    for sorter <- @sorters, a <- -1..1, b <- -1..1, c <- -1..1, d <- -1..1 do
      values = [a, b, c, d]
      assert sorter.sort(values) == Enum.sort(values), inspect(sorter)
    end
  end
end
