# learn-elixir-with-algorithm

## Getting Started

```bash
git clone https://github.com/jeonjw85/learn-elixir-with-algorithm.git
cd learn-elixir-with-algorithm
```

## Examples

```bash
mix algo fibonacci 10
mix algo hanoi 3

mix algo selection-sort 5 3 8 1 2
mix algo bubble-sort 5 3 8 1 2
mix algo insertion-sort 5 3 8 1 2
mix algo merge-sort 5 3 8 1 2
mix algo quick-sort 5 3 8 1 2

mix algo linear-search 8 3 8 5
mix algo binary-search 8 1 3 5 8 9

mix algo factorial 5
mix algo gcd 48 18
mix algo prime 29
```

## Run with Docker

```bash
docker run --rm -it -v "$PWD:/app" -w /app elixir:1.18-alpine sh
```

```bash
mix algo selection-sort 5 3 8 1 2
exit
```

## Help

```bash
mix algo --help
```

## Tests

```bash
mix test
```
