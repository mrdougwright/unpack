defmodule Unpack.MixProject do
  use Mix.Project

  def project do
    [
      app: :unpack,
      version: "0.1.0",
      elixir: "~> 1.6",
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
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mrdougwright/unpack"},
      files: [
        "lib/unpack.ex",
        "mix.exs",
        "README.md"
      ]
    ]
  end
end
