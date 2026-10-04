defmodule Mix.Tasks.Algo do
  use Mix.Task

  alias Algorithms.{Fibonacci, Hanoi}

  @shortdoc "정렬, 탐색, 수학 알고리즘을 실행합니다"
  @requirements ["compile"]

  def run(["fibonacci", input]) do
    input
    |> parse_number!()
    |> Fibonacci.calculate()
    |> IO.puts()
  end

  def run(["hanoi", input]) do
    input
    |> parse_number!()
    |> Hanoi.solve()
    |> Enum.with_index(1)
    |> Enum.each(fn {{disk, from, to}, step} ->
      IO.puts("#{step}. 원판 #{disk}: #{from} -> #{to}")
    end)
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
      mix algo hanoi <n>

    fibonacci: F(0) = 0, F(1) = 1 기준으로 n번째 값을 출력합니다.
    hanoi: 원판 n개를 A에서 C로 옮기는 순서를 출력합니다.
    """
  end
end
