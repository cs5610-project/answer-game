defmodule GameprojectWeb.SessionController do
  use GameprojectWeb, :controller

  alias Gameproject.Repo
  alias Gameproject.Accounts.{User, Auth}

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, session_params) do
    case Auth.login(session_params, Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_session(:current_username, user.username)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:error, "Incorrect email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> delete_session(:current_username)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

end
