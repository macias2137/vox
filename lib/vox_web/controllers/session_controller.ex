defmodule VoxWeb.SessionController do
  use VoxWeb, :controller

  alias Vox.UserManager
  alias Vox.UserManager.User
  alias Vox.UserManager.Guardian
  # use Plug.Conn

  def new(conn, _) do
    changeset = UserManager.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
    if maybe_user do
      redirect(conn, to: "/protected") #could it redirect to login page ?
    else
      render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end

  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
    UserManager.authenticate_user(username, password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    # |> assign(:current_user, %{})
    # |> render(conn, :logout, current_user: %{})
    |> redirect(to: "/logout")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:info, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> assign(:current_user, user)
    # |> Plug.Conn.assign(:current_user, user)
    # |> render(conn, :restaurants, current_user: user)
    |> redirect(to: "/restaurants")
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
