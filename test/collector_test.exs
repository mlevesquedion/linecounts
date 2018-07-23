defmodule CollectorTest do
  use ExUnit.Case
  import Linecounts.Collector

  setup do
    results = [{".exs", 1}, {".exs", 2}, {"", 3}]
    results_map = %{".exs" => 3, "" => 3}
    results_map_with_total = Map.merge(results_map, %{"total" => 6})
    %{results: results, results_map: results_map, with_total: results_map_with_total}
  end

  test "puts intermediate results into a map, with total lines", %{
    results: results,
    with_total: with_total
  } do
    assert collect_to_map(results) == with_total
  end

  test "calculates total lines", %{results: results} do
    assert calculate_total_lines(results) == 6
  end

  test "puts total lines in map", %{results_map: results_map, with_total: with_total} do
    assert insert_total_lines(results_map) == with_total
  end
end
