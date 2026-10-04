defmodule Algorithms.MathTest do
  use ExUnit.Case, async: true

  alias Algorithms.{Factorial, Gcd, Prime}

  test "0과 양의 정수의 팩토리얼을 계산한다" do
    assert Factorial.calculate(0) == 1
    assert Factorial.calculate(1) == 1
    assert Factorial.calculate(5) == 120
    assert Factorial.calculate(10) == 3_628_800
    assert Factorial.calculate(20) == 2_432_902_008_176_640_000
  end

  test "유클리드 호제법으로 최대공약수를 계산한다" do
    for {left, right, expected} <- [
          {48, 18, 6},
          {18, 48, 6},
          {17, 13, 1},
          {12, 12, 12},
          {0, 7, 7},
          {7, 0, 7},
          {0, 0, 0},
          {-48, 18, 6},
          {48, -18, 6},
          {-48, -18, 6}
        ] do
      assert Gcd.calculate(left, right) == expected
    end
  end

  test "소수와 합성수, 음수, 0과 1을 구분한다" do
    assert Enum.filter(0..30, &Prime.prime?/1) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

    for value <- [31, 97, 7919, 104_729] do
      assert Prime.prime?(value)
    end

    for value <- [-7, -1, 0, 1, 4, 49, 121, 169, 221, 7919 * 3] do
      refute Prime.prime?(value)
    end
  end
end
