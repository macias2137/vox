defmodule VoxWeb.PageController do
  use VoxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
