defmodule Algorithms.SearchTest do
  use ExUnit.Case, async: true

  alias Algorithms.LinearSearch

  test "선형 탐색은 정렬되지 않은 목록에서 첫 번째 위치를 찾는다" do
    assert LinearSearch.find([8, -3, 8, 2], 8) == 0
    assert LinearSearch.find([8, -3, 8, 2], -3) == 1
    assert LinearSearch.find([8, -3, 8, 2], 2) == 3
  end

  test "빈 목록이나 존재하지 않는 값은 nil을 반환한다" do
    for search <- [LinearSearch] do
      assert search.find([], 1) == nil

      for target <- [-10, 2, 10] do
        assert search.find([-3, 0, 4], target) == nil
      end
    end
  end
end
