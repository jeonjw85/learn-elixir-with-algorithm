defmodule Mix.Tasks.Algo do
  use Mix.Task

  alias Algorithms.Fibonacci

  @shortdoc "정렬, 탐색, 수학 알고리즘을 실행합니다"
  @requirements ["compile"]

  def run(["fibonacci", input]) do
    input
    |> parse_number!()
    |> Fibonacci.calculate()
    |> IO.puts()
  end

  def run(args) when args in [[], ["help"], ["--help"]] do
    IO.puts(usage())
  end

  def run(_args) do
    Mix.raise("명령을 확인해 주세요.\n\n" <> usage())
  end

  defp parse_number!(input) do
    case Integer.parse(input) do
      {number, ""} when number >= 0 -> number
      _ -> Mix.raise("n은 0 이상의 정수여야 합니다.")
    end
  end

  defp usage do
    """
    사용법:
      mix algo fibonacci <n>

    fibonacci: F(0) = 0, F(1) = 1 기준으로 n번째 값을 출력합니다.
    """
  end
end
