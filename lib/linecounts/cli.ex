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
    |> Linecounts.Collector.collect_to_map()
    |> Linecounts.Sorter.to_sorted_list()
    |> Linecounts.Formatter.format()
    |> IO.puts()
  end

  def get_ext_and_line_count(path) do
    {Path.extname(path), Linecounts.LineCounter.count_lines(path)}
  end
end
