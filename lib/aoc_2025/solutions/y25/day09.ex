defmodule Aoc2025.Solutions.Y25.Day09 do
  alias AoC.Input

  def parse(input, :part_one) do
    Input.read!(input)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ",") )
    |> Enum.map(fn row -> row |> Enum.map(&String.to_integer/1) |> List.to_tuple() end)
  end

  def parse(input, :part_two) do
    points =
      Input.read!(input)
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, ",") )
      |> Enum.map(fn row -> row |> Enum.map(&String.to_integer/1) |> List.to_tuple() end)

    points
    |> Enum.concat(Enum.take(points, 1))
    |> Enum.chunk_every(2, 1, :discard)
    |> then(fn lines -> {points, lines} end)
  end

  def part_one(problem) do
    problem
    |> Enum.with_index()
    |> Enum.map(
      fn {a, i} ->
        problem
        |> Stream.drop(i)
        |> Stream.map(&{a, &1, square_size(a, &1)})
        |> Enum.max_by(&elem(&1, 2))
      end
    )
    |> Enum.max_by(&elem(&1, 2))
    |> elem(2)
  end

  def part_two(problem) do
    {points, lines} = problem

    points
    |> Enum.with_index()
    |> Enum.map(
      fn {a, i} ->
        points
        |> Stream.drop(i)
        |> Stream.map(&{a, &1, square_size(a, &1)})
        |> Enum.max_by(&elem(&1, 2))
      end
    )
    |> Enum.sort_by(fn {_, _, size} -> size end, :desc)
    |> Enum.find(
      fn {{x1, y1}, {x2, y2}, _} ->
        not Enum.any?(
          points,
          fn {x3, y3} ->
            min(x1, x2) < x3 && max(x1, x2) > x3 && min(y1, y2) < y3 && max(y1, y2) > y3
          end
        )
        and not Enum.any?(
          lines,
          fn [{x3, y3}, {x4, y4}] ->
            x3 == x4 && x3 > min(x1, x2) && x3 < max(x1, x2) && (min(y1, y2) < y3 && max(y1, y2) > y3 || min(y1, y2) < y4 && max(y1, y2) > y4) ||
            y3 == y4 && y3 > min(y1, y2) && y3 < max(y1, y2) && (min(x1, x2) < x3 && max(x1, x2) > x3 || min(x1, x2) < x4 && max(x1, x2) > x4)
          end
        )
      end
    )
    # |> IO.inspect(label: "Found")
    |> elem(2)
  end

  defp square_size({x1, y1}, {x2, y2}) do
    (Kernel.abs(x2 - x1) + 1) * (Kernel.abs(y2 - y1) + 1)
  end
end
