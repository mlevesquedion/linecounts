defmodule CliTest do
  use ExUnit.Case
  import Linecounts.CLI

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "extracts the path" do
    assert parse_args(["path"]) == "path"
  end
end
