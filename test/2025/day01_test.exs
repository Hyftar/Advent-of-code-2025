defmodule Aoc2025.Solutions.Y25.Day01Test do
  alias AoC.Input, warn: false
  alias Aoc2025.Solutions.Y25.Day01, as: Solution, warn: false
  use ExUnit.Case, async: true

  defp solve(input, part) do
    problem =
      input
      |> Input.as_file()
      |> Solution.parse(part)

    apply(Solution, part, [problem])
  end

  test "loops correctly right" do
    input = ~S"""
    R50
    R99
    R1
    R100
    R98
    R2
    """

    assert 4 == solve(input, :part_one)
  end

  test "loops correctly left" do
    input = ~S"""
    L50
    R5
    L10
    R15
    L10
    """

    assert 2 == solve(input, :part_one)
  end

  test "should solve example correctly" do
    input = ~S"""
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    """

    assert 3 == solve(input, :part_one)
  end

  @part_one_solution 1084

  test "part one solution" do
    assert {:ok, @part_one_solution} == AoC.run(2025, 1, :part_one)
  end

  test "part two example" do
    input = ~S"""
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    R1000
    L1000
    """

    assert 26 == solve(input, :part_two)
  end

  @part_two_solution 6475

  test "part two solution" do
    assert {:ok, @part_two_solution} == AoC.run(2025, 1, :part_two)
  end
end
