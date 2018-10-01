defmodule Unpack.MixProject do
  use Mix.Project

  def project do
    [
      app: :unpack,
      version: "0.1.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "Unpack",
      description: "Reach in and unpack any value from a nested map.",
      source_url: "https://github.com/mrdougwright/unpack",
      docs: [
        main: "unpack",
        extras: ["README.md"]
      ],
      package: package(),
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
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:ecto, "~> 2.0", only: :dev}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mrdougwright/unpack"},
      maintainers: ["Doug Wright", "et al"],
      files: [
        "lib/unpack.ex",
        "mix.exs",
        "README.md"
      ]
    ]
  end
end
