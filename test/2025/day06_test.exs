defmodule Aoc2025.Solutions.Y25.Day06Test do
  alias AoC.Input, warn: false
  alias Aoc2025.Solutions.Y25.Day06, as: Solution, warn: false
  use ExUnit.Case, async: true

  defp solve(input, part) do
    problem =
      input
      |> Input.as_file()
      |> Solution.parse(part)

    apply(Solution, part, [problem])
  end

  test "part one example" do
    input = ~S"""
    123 328  51 64
     45 64  387 23
      6 98  215 314
    *   +   *   +
    """

    assert 4_277_556 == solve(input, :part_one)
  end

  @part_one_solution 5_316_572_080_628

  test "part one solution" do
    assert {:ok, @part_one_solution} == AoC.run(2025, 6, :part_one)
  end

  test "part two example" do
    input = ~S"""
    123 328  51 6
     45 64  387 2
      6 98  215 3
    *   +   *   +
    """

    assert 3_263_392 == solve(input, :part_two)
  end

  test "get a vertical number" do
    lines = [
      "123 328  51 64 ",
      " 45 64  387 23 ",
      "  6 98  215 314"
    ]

    assert nil == Solution.vertical_number(lines, 3)

    assert 24 == Solution.vertical_number(lines, 1)
    assert 356 == Solution.vertical_number(lines, 2)
    assert 369 == Solution.vertical_number(lines, 4)
    assert 248 == Solution.vertical_number(lines, 5)
    assert 4 == Solution.vertical_number(lines, 14)
  end

  @part_two_solution 11_299_263_623_062

  test "part two solution" do
    assert {:ok, @part_two_solution} == AoC.run(2025, 6, :part_two)
  end
end
