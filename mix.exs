defmodule LoggerStatsd.Mixfile do
  use Mix.Project

  def project do
    [app: :logger_statsd,
     version: "0.1.4",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger], mod: {LoggerStatsd, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:buffer, "~> 0.3.9"},
    {:ex_statsd, "~> 0.5.3"},
    {:ex_doc, ">= 0.0.0", only: :dev},
    {:credo, "~> 0.4", only: [:dev, :test]}]
  end

  defp description do
    """
    Error logger backend for statsd
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :logger_statsd,
     files: ["lib", "mix.exs", "README*", "LICENSE*",],
     maintainers: ["Steffel Fénix"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/steffenix/logger_statsd"}]
  end
end
