defmodule ExActorDemo.Mixfile do
  use Mix.Project

  def project do
    [app: :exactor_demo, version: "0.0.1", deps: deps]
  end

  def application do [] end

  defp deps do
    [{:exactor, "0.1", git: "https://github.com/sasa1977/exactor.git" }]
  end
end
