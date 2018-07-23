defmodule Linecounts.CLI do
  def main(argv) do
    argv
    |> parse_args()
    |> process
  end

  def parse_args(argv) do
    argv
    |> to_internal_repr()
  end

  def to_internal_repr([arg | _rest]) when arg in ["-h", "--help"],
    do: :help

  def to_internal_repr([path]),
    do: path

  def to_internal_repr(_), do: :help

  def process(:help) do
    IO.puts("""
    usage: linecounts <path>
    """)

    System.halt(0)
  end

  def process(path) do
    path
    |> DirWalker.stream()
    |> Stream.map(&get_ext_and_line_count/1)
    |> put_into_map
    |> insert_total_lines
    |> Linecounts.Formatter.format()
    |> IO.puts()
  end

  def put_into_map(results) do
    Enum.reduce(results, %{}, &update_map/2)
  end

  def get_ext_and_line_count(path) do
    {Path.extname(path), Linecounts.LineCounter.count_lines(path)}
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
