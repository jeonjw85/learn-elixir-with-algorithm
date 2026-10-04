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

  test "탐색한 값의 인덱스를 출력한다" do
    assert capture_io(fn -> Algo.run(["linear-search", "8", "3", "8", "8"]) end) == "1\n"
    assert capture_io(fn -> Algo.run(["binary-search", "8", "3", "5", "8"]) end) == "2\n"
  end

  test "탐색할 값이 없으면 안내를 출력한다" do
    for command <- ["linear-search", "binary-search"] do
      assert capture_io(fn -> Algo.run([command, "7", "1", "3"]) end) ==
               "찾을 수 없습니다.\n"

      assert capture_io(fn -> Algo.run([command, "7"]) end) == "찾을 수 없습니다.\n"
    end
  end

  test "정렬되지 않은 이진 탐색 입력을 거부한다" do
    assert_raise Mix.Error, "이진 탐색에는 오름차순으로 정렬된 정수 목록이 필요합니다.", fn ->
      Algo.run(["binary-search", "3", "5", "3", "1"])
    end
  end

  test "팩토리얼, 최대공약수, 소수 판별 결과를 출력한다" do
    assert capture_io(fn -> Algo.run(["factorial", "5"]) end) == "120\n"
    assert capture_io(fn -> Algo.run(["gcd", "-48", "18"]) end) == "6\n"
  end

  test "명령이 없거나 도움말을 요청하면 사용법을 출력한다" do
    for args <- [[], ["help"], ["--help"]] do
      output = capture_io(fn -> Algo.run(args) end)

      assert output =~ "mix algo fibonacci <n>"
      assert output =~ "mix algo hanoi <n>"

      for command <- @sort_commands ++ ["linear-search", "binary-search", "factorial", "gcd"] do
        assert output =~ "mix algo #{command}"
      end
    end
  end

  test "음수와 정수가 아닌 입력을 거부한다" do
    for command <- ["fibonacci", "hanoi", "factorial"],
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
      ["quick-sort", "2", "abc"],
      ["linear-search", "abc", "1"],
      ["linear-search", "1", "abc"],
      ["binary-search", "1.5", "1"],
      ["binary-search", "1", "abc"],
      ["gcd", "abc", "2"],
      ["gcd", "2", "abc"]
    ]

    for args <- inputs do
      assert_raise Mix.Error, "입력은 정수여야 합니다.", fn -> Algo.run(args) end
    end
  end

  test "알 수 없는 명령과 잘못된 인자 개수를 거부한다" do
    for args <- [
          ["unknown", "3"],
          ["fibonacci"],
          ["hanoi", "3", "extra"],
          ["factorial"],
          ["gcd", "12"],
          ["gcd", "12", "6", "3"],
          ["linear-search"],
          ["binary-search"]
        ] do
      assert_raise Mix.Error, ~r/명령을 확인해 주세요/, fn -> Algo.run(args) end
    end
  end
end
