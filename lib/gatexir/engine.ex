defmodule Gatexir.Engine do
  use GenServer

  alias Plug.Conn

  def init(_opts) do
    config = Gatexir.Config.load("config.yml")

    {:ok, config: config}
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # here we will make http request to proceed based on config e return it for other module dispatch the given request
  def route(%Conn{} = conn) do
    %Conn{method: method, path_info: path_info} = conn |> IO.inspect()

    [_ | path] = path_info

    IO.inspect(path, label: "path")

    :ok
  end
end
