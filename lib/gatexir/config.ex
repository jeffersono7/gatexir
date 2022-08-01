defmodule Gatexir.Config do
  defstruct [:mappings]

  def load(filename) do
    File.cwd!()
    |> Path.join(["mapping/", filename])
    |> YamlElixir.read_from_file()
    |> parse()
  end

  defp parse({:ok, %{"mappings" => mappings} = config_map}) when is_map(config_map) do
    struct =
      for {service, config} <- mappings, reduce: %{} do
        acc ->
          default = %{match: config["match"], to: config["to"]}

          Map.update(acc, String.to_atom(service), default, fn _ -> config end)
      end

    {:ok, struct}
  end

  defp parse(params), do: params
end
