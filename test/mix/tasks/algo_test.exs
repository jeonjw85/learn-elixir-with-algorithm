defmodule Mix.Tasks.AlgoTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  alias Mix.Tasks.Algo

  @sort_commands ["selection-sort", "bubble-sort", "insertion-sort", "merge-sort", "quick-sort"]

  test "피보나치 결과를 출력한다" do
    assert capture_io(fn -> Algo.run(["fibonacci", "10"]) end) == "55\n"
  end

  test "하노이 이동 순서를 출력한다" do
    assert capture_io(fn -> Algo.run(["hanoi", "2"]) end) ==
             "1. 원판 1: A -> B\n2. 원판 2: A -> C\n3. 원판 1: B -> C\n"
  end

  test "모든 정렬 명령으로 음수와 중복 값을 정렬한다" do
    for command <- @sort_commands do
      assert capture_io(fn -> Algo.run([command, "5", "-1", "3", "5", "0"]) end) ==
               "[-1, 0, 3, 5, 5]\n"
    end
  end

  test "빈 목록과 문자 코드도 정수 목록으로 출력한다" do
    for command <- @sort_commands do
      assert capture_io(fn -> Algo.run([command]) end) == "[]\n"
      assert capture_io(fn -> Algo.run([command, "66", "65"]) end) == "[65, 66]\n"
    end
  end

  test "명령이 없거나 도움말을 요청하면 사용법을 출력한다" do
    for args <- [[], ["help"], ["--help"]] do
      output = capture_io(fn -> Algo.run(args) end)

      assert output =~ "mix algo fibonacci <n>"
      assert output =~ "mix algo hanoi <n>"

      for command <- @sort_commands do
        assert output =~ "mix algo #{command}"
      end
    end
  end

  test "음수와 정수가 아닌 입력을 거부한다" do
    for command <- ["fibonacci", "hanoi"],
        input <- ["-1", "1.5", "3abc", "abc", ""] do
      assert_raise Mix.Error, "n은 0 이상의 정수여야 합니다.", fn ->
        Algo.run([command, input])
      end
    end
  end

  test "정렬, 탐색, 수학 명령의 정수가 아닌 입력을 거부한다" do
    inputs = [
      ["selection-sort", "1.5"],
      ["bubble-sort", "abc"],
      ["insertion-sort", "3abc"],
      ["merge-sort", ""],
      ["quick-sort", "2", "abc"]
    ]

    for args <- inputs do
      assert_raise Mix.Error, "입력은 정수여야 합니다.", fn -> Algo.run(args) end
    end
  end

  test "알 수 없는 명령과 잘못된 인자 개수를 거부한다" do
    for args <- [
          ["unknown", "3"],
          ["fibonacci"],
          ["hanoi", "3", "extra"]
        ] do
      assert_raise Mix.Error, ~r/명령을 확인해 주세요/, fn -> Algo.run(args) end
    end
  end
end
