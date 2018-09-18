defmodule Beewi.MixProject do
  use Mix.Project

  def project do
    [
      app: :beewi,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Beewi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nadia, "~> 0.4.4"},
      {:bifrost, git: "git@github.com:ryancrum/bifrost.git", branch: "master", app: false}
    ]
  end
end
