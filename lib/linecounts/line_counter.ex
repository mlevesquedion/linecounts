defmodule Linecounts.LineCounter do
  def count_lines([filename]), do: count_lines(filename)

  def count_lines(filename) do
    File.stream!(filename)
    |> Enum.to_list()
    |> length
  end
end
