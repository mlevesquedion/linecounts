defmodule LineCounterTest do
  use ExUnit.Case
  import LineCounter

  setup do
    n = 3
    file = create_file_with_lines(n)
    %{filename: file}
  end

  test "returns the correct number of lines", %{filename: file} do
    assert 3 == LineCounter.count_lines(file)
    File.rm(file)
  end

  defp create_file_with_lines(n) do
    filename = "test#{DateTime.utc_now()}"
    {:ok, file} = File.open(filename, [:write])
    for _ <- 1..n, do: IO.binwrite(file, "line\n")
    File.close(file)
    filename
  end
end
