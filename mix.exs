defmodule Linecounts.MixProject do
  use Mix.Project

  def project do
    [
      app: :linecounts,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript_config()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:dir_walker, "~> 0.0.7"}
    ]
  end

  defp escript_config do
    [
      main_module: Linecounts.CLI
    ]
  end
end
