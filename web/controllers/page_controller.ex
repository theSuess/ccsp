defmodule Ccsp.PageController do
  use Ccsp.Web, :controller

  alias Ccsp.Challenge

  def index(conn, _params) do
    if Guardian.Plug.authenticated? conn do
      conn
      |> redirect(to: dashboard_page_path(conn,:dashboard_index))
    else
      conn
      |> put_layout("login.html")
      |> render("login.html")
    end
  end

  def admin_index(conn, _params) do
    conn
    |> Guardian.Plug.sign_out # Sign out so Guardian does not get confused
    |> render("admin.html")
  end

  def dashboard_index(conn, _params) do
    challenges = Repo.all(Challenge)
    render conn, "index.html", challenges: challenges
  end
end
