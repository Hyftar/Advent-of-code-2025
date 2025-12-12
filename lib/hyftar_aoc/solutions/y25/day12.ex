defmodule HyftarAoc.Solutions.Y25.Day12 do
  alias AoC.Input

  def parse(input, _part) do
    input = Input.read!(input)

    patterns =
      input
      |> then(fn input -> Regex.scan(~r/(\d+):\n(.+?)\n\n/s, input) end)
      |> Enum.map(fn [_, id, pattern] ->
        pattern
        |> String.split("\n")
        |> Enum.map(&String.graphemes/1)
        |> then(fn pattern ->
          space_taken =
            pattern
            |> Enum.map(fn line ->
              Enum.count(line, fn char -> char == "#" end)
            end)
            |> Enum.sum()

          {String.to_integer(id), %{pattern: pattern, space_taken: space_taken}}
        end)
      end)
      |> Enum.into(%{})

    regions =
      input
      |> then(fn input -> Regex.scan(~r/^(\d+x\d+): ((?:\d\s?)+)$/m, input) end)
      |> Enum.map(fn [_, size, region] ->
        region
        |> String.trim()
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)
        |> then(fn region ->
          {
            String.split(size, "x")
            |> Enum.map(&String.to_integer/1),
            region
          }
        end)
      end)

    {patterns, regions}
  end

  def part_one(problem) do
    {patterns, regions} = problem

    regions
    |> Stream.filter(fn {[width, height], counts} ->
      counts
      |> Enum.with_index()
      |> Enum.map(fn {count, index} ->
        patterns[index][:space_taken] * count
      end)
      |> Enum.sum()
      |> Kernel.<(width * height)
    end)
    |> Enum.count()
  end

  # No part two for this one!
  #
  # def part_two(problem) do
  #   problem
  # end
end
