defmodule Algorithms.MathTest do
  use ExUnit.Case, async: true

  alias Algorithms.Factorial

  test "0과 양의 정수의 팩토리얼을 계산한다" do
    assert Factorial.calculate(0) == 1
    assert Factorial.calculate(1) == 1
    assert Factorial.calculate(5) == 120
    assert Factorial.calculate(10) == 3_628_800
    assert Factorial.calculate(20) == 2_432_902_008_176_640_000
  end
end
