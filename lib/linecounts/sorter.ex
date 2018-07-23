defmodule Linecounts.Sorter do
  def to_sorted_list(map) do
    map
    |> Map.to_list()
    |> List.keysort(1)
  end
end
