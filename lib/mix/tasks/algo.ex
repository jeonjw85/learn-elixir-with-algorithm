defmodule Mix.Tasks.Algo do
  use Mix.Task

  alias Algorithms.{
    BinarySearch,
    BubbleSort,
    Factorial,
    Fibonacci,
    Gcd,
    Hanoi,
    InsertionSort,
    LinearSearch,
    MergeSort,
    Prime,
    QuickSort,
    SelectionSort
  }

  @shortdoc "정렬, 탐색, 수학 알고리즘을 실행합니다"
  @requirements ["compile"]

  @sorters %{
    "selection-sort" => SelectionSort,
    "bubble-sort" => BubbleSort,
    "insertion-sort" => InsertionSort,
    "merge-sort" => MergeSort,
    "quick-sort" => QuickSort
  }

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

  def run([command | inputs]) when is_map_key(@sorters, command) do
    sorter = Map.fetch!(@sorters, command)

    inputs
    |> parse_numbers!()
    |> sorter.sort()
    |> IO.inspect(charlists: :as_lists, limit: :infinity)
  end

  def run(["linear-search", target | inputs]) do
    target = parse_integer!(target)

    inputs
    |> parse_numbers!()
    |> LinearSearch.find(target)
    |> print_search_result()
  end

  def run(["binary-search", target | inputs]) do
    target = parse_integer!(target)
    values = parse_numbers!(inputs)

    unless values |> Enum.chunk_every(2, 1, :discard) |> Enum.all?(fn [a, b] -> a <= b end) do
      Mix.raise("이진 탐색에는 오름차순으로 정렬된 정수 목록이 필요합니다.")
    end

    values
    |> BinarySearch.find(target)
    |> print_search_result()
  end

  def run(["factorial", input]) do
    input
    |> parse_number!()
    |> Factorial.calculate()
    |> IO.puts()
  end

  def run(["gcd", left, right]) do
    left
    |> parse_integer!()
    |> Gcd.calculate(parse_integer!(right))
    |> IO.puts()
  end

  def run(["prime", input]) do
    input
    |> parse_integer!()
    |> Prime.prime?()
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

  defp parse_integer!(input) do
    case Integer.parse(input) do
      {number, ""} -> number
      _ -> Mix.raise("입력은 정수여야 합니다.")
    end
  end

  defp parse_numbers!(inputs) do
    Enum.map(inputs, &parse_integer!/1)
  end

  defp print_search_result(nil), do: IO.puts("찾을 수 없습니다.")
  defp print_search_result(index), do: IO.puts(index)

  defp usage do
    """
    사용법:
      mix algo fibonacci <n>
      mix algo hanoi <n>
      mix algo selection-sort [정수 ...]
      mix algo bubble-sort [정수 ...]
      mix algo insertion-sort [정수 ...]
      mix algo merge-sort [정수 ...]
      mix algo quick-sort [정수 ...]
      mix algo linear-search <찾을 값> [정수 ...]
      mix algo binary-search <찾을 값> [정렬된 정수 ...]
      mix algo factorial <n>
      mix algo gcd <정수> <정수>
      mix algo prime <정수>

    fibonacci: F(0) = 0, F(1) = 1 기준으로 n번째 값을 출력합니다.
    hanoi: 원판 n개를 A에서 C로 옮기는 순서를 출력합니다.
    정렬: 정수 목록을 오름차순으로 출력합니다.
    탐색: 찾은 위치를 0부터 시작하는 인덱스로 출력합니다.
    linear-search: 같은 값이 여러 개면 첫 번째 위치를 출력합니다.
    binary-search: 오름차순 입력이 필요하며, 일치하는 위치 중 하나를 출력합니다.
    factorial: 0 이상의 정수 n의 팩토리얼을 출력합니다.
    gcd: 두 정수의 최대공약수를 출력합니다.
    prime: 소수이면 true, 아니면 false를 출력합니다.
    """
  end
end
