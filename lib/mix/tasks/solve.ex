defmodule Mix.Tasks.Solve do
  @moduledoc """
  Wrapper around mix aoc.run that ensures the application is started.
  This is needed for libraries like memoize that require app initialization.

  Usage: mix aoc_run [same arguments as mix aoc.run]
  """

  use Mix.Task

  @shortdoc "Runs aoc.run with app started"
  @requirements ["app.start"]

  def run(args) do
    Mix.Task.run("aoc.run", args)
  end
end
