defmodule DurgaTransport.Mixfile do
  use Mix.Project

  def project do
    [app: :durga_transport,
     version: "1.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:msgpack, github: "msgpack/msgpack-erlang", ref: "0.3.3"},]
  end
end
