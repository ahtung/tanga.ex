defmodule Tanga.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tanga,
      version: "0.7.0",
      elixir: "~> 1.3",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      preferred_cli_env: [espec: :test, coveralls: :test],
      test_coverage: [tool: ExCoveralls, test_task: "espec"],
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:espec, "~> 1.4.6", only: :test},
      {:excoveralls, "~> 0.8", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end

  # Package Information
  defp package do
    [
      files: ["spec", "lib", "mix.exs", "README.md", "LICENSE*"],
      maintainers: ["Dunya Kirkali", "Onur Kucukkece"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/ahtung/tanga.ex"}
    ]
  end

  # Package description
  defp description do
    """
    Sexier strings for Elixir
    """
  end
end
