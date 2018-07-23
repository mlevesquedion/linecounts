defmodule CliTest do
  use ExUnit.Case
  import Linecounts.CLI

  setup do
    results = [{".exs", 1}, {".exs", 2}, {"", 3}]
    results_map = %{".exs" => 3, "" => 3}
    %{results: results, results_map: results_map}
  end

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "extracts the path" do
    assert parse_args(["path"]) == "path"
  end

  test "puts intermediate results into a map", %{results: results, results_map: results_map} do
    assert put_into_map(results) == results_map
  end

  test "calculates total lines", %{results: results} do
    assert calculate_total_lines(results) == 6
  end

  test "puts total lines in map", %{results_map: results_map} do
    assert insert_total_lines(results_map) == Map.merge(results_map, %{"total" => 6})
  end
end
