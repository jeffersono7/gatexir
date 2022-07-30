defmodule Gatexir.Config do

  def load(filename) do
    File.cwd!()
    |> Path.join(["mapping/", filename])
    |> YamlElixir.read_from_file()
  end
end
