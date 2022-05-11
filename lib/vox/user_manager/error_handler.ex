defmodule Vox.UserManager.ErrorHandler do
  import Plug.Conn
  import Phoenix.Controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)
    conn
    |> redirect(to: "/login")
    |> halt()
  end
end
