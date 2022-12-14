defmodule GatexirWeb.HandlerController do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    Gatexir.Engine.route(conn)

    conn
    |> put_status(:not_found)
    |> send_resp(404, "Okay with error ;)")
  end
end
