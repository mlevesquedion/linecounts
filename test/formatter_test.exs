defmodule FormatterTest do
  use ExUnit.Case

  setup do
    result_set = [{".exs", 2}, {".js", 8}, {"total", 10}]

    single = ".exs         | 10                          | 100"

    table = """
    Extension    | Lines                       | % of total
    -------------+-----------------------------+-----------
    .exs         | 2                           | 20
    .js          | 8                           | 80
    -------------+-----------------------------+-----------
    Total : 10 lines
    """

    %{results: result_set, table: table, single: single}
  end

  test "formats a result set into a nice display", %{results: result_set, table: table} do
    assert Linecounts.Formatter.format(result_set) == table
  end

  test "formats a single line", %{results: result_set, single: single} do
    assert Linecounts.Formatter.format_line(10, {".exs", 10}) == single
  end
end
