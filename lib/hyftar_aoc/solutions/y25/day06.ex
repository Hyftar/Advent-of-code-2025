defmodule HyftarAoc.Solutions.Y25.Day06 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
  end

  def transpose(list) do
    Enum.zip_with(list, &Function.identity/1)
  end

  def vertical_number(lines, index) do
    lines
    |> Enum.map(fn line -> line |> String.at(index) |> String.trim() end)
    |> Enum.join()
    |> String.trim()
    |> then(fn
      "" -> nil
      val -> String.to_integer(val)
    end)
  end

  def part_one(problem) do
    problem
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ~r/\s+/, trim: true))
    |> transpose()
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(fn [instruction | rest] ->
      {instruction, Enum.map(rest, &String.to_integer/1)}
    end)
    |> Enum.map(fn
      {"+", elems} -> Enum.reduce(elems, 0, &(&1 + &2))
      {"*", elems} -> Enum.reduce(elems, 1, &(&1 * &2))
    end)
    |> Enum.sum()
  end

  def part_two(problem) do
    {operators, lines} =
      problem
      |> String.split("\n", trim: true)
      |> List.pop_at(-1)

    operators
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(
      %{operator: nil, total: 0, current_total: 0},
      fn
        {"+", index}, %{total: total, current_total: current_total} ->
          %{
            operator: :+,
            total: total + current_total,
            current_total: vertical_number(lines, index) || 0
          }

        {"*", index}, %{total: total, current_total: current_total} ->
          %{
            operator: :*,
            total: total + current_total,
            current_total: vertical_number(lines, index) || 1
          }

        {" ", index}, %{current_total: current_total} = acc ->
          vertical_number(lines, index)
          |> then(fn
            nil -> current_total
            value -> Kernel.apply(Kernel, acc.operator, [current_total, value])
          end)
          |> then(fn result ->
            %{acc | current_total: result}
          end)
      end
    )
    |> then(fn %{total: total, current_total: current_total} ->
      total + current_total
    end)
  end
end
