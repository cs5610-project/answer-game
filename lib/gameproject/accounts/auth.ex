defmodule Gameproject.Accounts.Auth do
  alias Gameproject.Accounts.{Encryption, User}

  def login(params, repo) do
    user = repo.get_by(User, email: String.downcase(params["email"]))
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  def authenticate(user, password) do
    case user do
      nil -> false
      _ -> Encryption.validate_password(password, user.password_hash)
    end
  end

  ## Helper functions for view ##
  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id do
      Gameproject.Repo.get(User, id)
    end
  end

  def logged_in?(conn) do
    ## !! is not not, forcing true or false
    !! current_user(conn)
  end

end
