defmodule Linecounts.Collector do
  def collect(results) do
    results
    |> Enum.reduce(%{}, &update_map/2)
    |> insert_total_lines
  end

  def update_map({ext, lines}, map) do
    Map.update(map, ext, lines, &(&1 + lines))
  end

  def insert_total_lines(results) do
    Map.put(results, "total", calculate_total_lines(results))
  end

  def calculate_total_lines(results) do
    Enum.reduce(results, 0, fn {_key, lines}, total -> total + lines end)
  end
end
