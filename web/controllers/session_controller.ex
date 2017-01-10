defmodule Ccsp.SessionController do
  use Ccsp.Web, :controller

  def new(conn, _) do
    render conn,"new.html"
  end

  def create(conn, %{"session" => %{"name" => user,"token" => token}}) do
    case Ccsp.Auth.login_by_name_and_token(conn, user, token, repo: Repo) do
      {:ok, conn} ->
        logged_in_user = Guardian.Plug.current_resource(conn)
        conn
        |> put_flash(:info, "Innlogget")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Wrong username/password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out
    |> redirect(to: "/")
  end
end
