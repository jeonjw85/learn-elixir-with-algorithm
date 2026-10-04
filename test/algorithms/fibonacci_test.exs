defmodule Algorithms.FibonacciTest do
  use ExUnit.Case, async: true

  alias Algorithms.Fibonacci

  test "피보나치 수열의 시작 값" do
    assert Fibonacci.calculate(0) == 0
    assert Fibonacci.calculate(1) == 1
    assert Fibonacci.calculate(2) == 1
  end

  test "n번째 피보나치 값" do
    assert Fibonacci.calculate(10) == 55
    assert Fibonacci.calculate(50) == 12_586_269_025
  end
end
