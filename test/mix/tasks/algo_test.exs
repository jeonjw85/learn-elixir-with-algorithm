defmodule Mix.Tasks.AlgoTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  alias Mix.Tasks.Algo

  test "피보나치 결과를 출력한다" do
    assert capture_io(fn -> Algo.run(["fibonacci", "10"]) end) == "55\n"
  end

  test "명령이 없거나 도움말을 요청하면 사용법을 출력한다" do
    for args <- [[], ["help"], ["--help"]] do
      output = capture_io(fn -> Algo.run(args) end)

      assert output =~ "mix algo fibonacci <n>"
    end
  end

  test "음수와 정수가 아닌 입력을 거부한다" do
    for command <- ["fibonacci"],
        input <- ["-1", "1.5", "3abc", "abc", ""] do
      assert_raise Mix.Error, "n은 0 이상의 정수여야 합니다.", fn ->
        Algo.run([command, input])
      end
    end
  end

  test "알 수 없는 명령과 잘못된 인자 개수를 거부한다" do
    for args <- [
          ["unknown", "3"],
          ["fibonacci"]
        ] do
      assert_raise Mix.Error, ~r/명령을 확인해 주세요/, fn -> Algo.run(args) end
    end
  end
end
