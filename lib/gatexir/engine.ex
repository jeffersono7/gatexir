defmodule Gatexir.Engine do
  use GenServer

  alias Plug.Conn

  @impl true
  def init(_opts) do
    with {:ok, config} <- Gatexir.Config.load("config.yml") do
      {:ok, config: config}
    else
      _ -> raise "Invalid or missing configuration gateway file"
    end
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def handle_call({:route, _path_info}, _from, config: config) do
    request = nil

    # here will match whitch url will route

    {:reply, request, config: config}
  end

  # here we will make http request to proceed based on config e return it for other module dispatch the given request
  def route(%Conn{} = conn) do
    %Conn{method: _method, path_info: path_info} =
      conn
      |> IO.inspect()

    [_ | path] = path_info

    IO.inspect(path, label: "path")

    case GenServer.call(__MODULE__, {:route, path}) do
      nil -> {:error, :no_matched}
      to -> to
    end
  end
end
