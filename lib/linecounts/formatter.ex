defmodule Linecounts.Formatter do
  def format(result_set = %{"total" => total}) do
    lines =
      result_set
      |> Map.delete("total")
      |> Enum.map(&format_line(total, &1))
      |> Enum.join("\n")

    header() <> lines <> footer(total)
  end

  def format_line(total, {ext, count}) do
    String.pad_trailing("#{ext}", 12) <>
      " | " <> String.pad_trailing("#{count}", 27) <> " | #{round(count / total * 100)}"
  end

  defp header() do
    """
    Extension    | Lines                       | % of total
    -------------+-----------------------------+-----------
    """
  end

  defp footer(lines) do
    """

    -------------+-----------------------------+-----------
    Total : #{lines} lines
    """
  end
end
