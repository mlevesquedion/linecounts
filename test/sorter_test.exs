defmodule SorterTest do
  use ExUnit.Case
  import Linecounts.Sorter

  setup do
    map = %{"" => 1, "thing" => 10, "other" => 5}
    expected = [{"", 1}, {"other", 5}, {"thing", 10}]
    %{map: map, expected: expected}
  end

  test "converts a map to a list, sorted by the maps' values", %{map: map, expected: expected} do
    assert to_sorted_list(map) == expected
  end
end
