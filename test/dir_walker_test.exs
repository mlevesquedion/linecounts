defmodule DirWalkerTest do
  use ExUnit.Case

  test "test api" do
    assert ["/usr/bin/uux"] == DirWalker.stream("/") |> Enum.take(1)
  end
end
