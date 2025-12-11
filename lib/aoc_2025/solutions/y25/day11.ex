defmodule Aoc2025.Solutions.Y25.Day11 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ": "))
    |> Enum.map(
      fn [input, output] ->
        output
        |> String.split(" ")
        |> then(fn output -> {input, output} end)
      end
    )
    |> Enum.reduce(
      %{},
      fn {input, output}, graph ->
        Map.put(graph, input, output)
      end
    )
  end

  def part_one(problem) do
    count_paths("you", problem)
  end

  def count_paths(current, graph, visited \\ MapSet.new())

  def count_paths("out", _graph, _visited), do: 1

  def count_paths(current, graph, visited) do
    visited = MapSet.put(visited, current)

    Map.get(graph, current)
    |> Enum.map(
      fn next ->
        if MapSet.member?(visited, next) do
          0
        else
          count_paths(next, graph, visited)
        end
      end
    )
    |> Enum.sum()
  end

  # def part_two(problem) do
  #   problem
  # end
end
