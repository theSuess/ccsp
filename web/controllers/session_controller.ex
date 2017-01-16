defmodule Ccsp.SessionController do
  use Ccsp.Web, :controller

  def create(conn, %{"session" => %{"name" => user,"token" => token}}) do
    case Ccsp.Auth.login_by_name_and_token(conn, user, token, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Successfully logged in")
        |> redirect(to: dashboard_page_path(conn, :dashboard_index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Wrong username/password")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end
end
