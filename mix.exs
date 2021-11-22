defmodule ElixirStartingPoint.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_starting_point,
      version: "0.1.0",
      build_path: "_build",
      deps_path: "deps",
      lockfile: "mix.lock",
      elixir: "~> 1.12",
      consolidate_protocols: Mix.env() != :test,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        plt_add_apps: [:elixir, :mix],
        flags: [
          :error_handling,
          :race_conditions,
          :underspecs
        ],
        ignore_warnings: ".dialyzer_ignore.exs"
      ]
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:credo, "~> 1.6.1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.14", only: [:dev, :test], runtime: false}
    ]
  end
end
