defmodule Ccsp.Auth do
  import Plug.Conn

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user, :access)
  end

  def login_by_name_and_token(conn, name, token, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Ccsp.User, name: name)

    cond do
      user && token == user.token ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        {:error, :not_found, conn}
    end
  end
end
