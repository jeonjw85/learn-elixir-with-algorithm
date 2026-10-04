defmodule Algorithms.SearchTest do
  use ExUnit.Case, async: true

  alias Algorithms.{BinarySearch, LinearSearch}

  test "선형 탐색은 정렬되지 않은 목록에서 첫 번째 위치를 찾는다" do
    assert LinearSearch.find([8, -3, 8, 2], 8) == 0
    assert LinearSearch.find([8, -3, 8, 2], -3) == 1
    assert LinearSearch.find([8, -3, 8, 2], 2) == 3
  end

  test "이진 탐색은 정렬된 목록의 모든 위치를 찾는다" do
    for values <- [[4], [-5, 0], [-5, -2, 0, 3, 9], Enum.to_list(-10..10)],
        {target, index} <- Enum.with_index(values) do
      assert BinarySearch.find(values, target) == index
    end
  end

  test "중복 값이 있는 목록에서도 이진 탐색으로 일치하는 위치를 찾는다" do
    values = [-2, -2, 1, 1, 1, 3, 3]

    for target <- [-2, 1, 3] do
      index = BinarySearch.find(values, target)
      assert is_integer(index)
      assert Enum.at(values, index) == target
    end
  end

  test "빈 목록이나 존재하지 않는 값은 nil을 반환한다" do
    for search <- [LinearSearch, BinarySearch] do
      assert search.find([], 1) == nil

      for target <- [-10, 2, 10] do
        assert search.find([-3, 0, 4], target) == nil
      end
    end
  end
end
