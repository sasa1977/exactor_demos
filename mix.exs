defmodule ExActorDemo.Mixfile do
  use Mix.Project

  def project do
    [app: :exactor_demos, version: "0.0.1", deps: deps]
  end

  def application do [] end

  defp deps do
    [
      {:exactor, "0.1", github: "sasa1977/exactor" },
      {:poolboy, github: "devinus/poolboy"}
    ]
  end
end
