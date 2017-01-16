defmodule Ccsp.Token do
  use Ccsp.Web, :controller
  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:info, "You must be signed in to access this page")
    |> redirect(to: page_path(conn, :index))
  end

  def unauthorized(conn, _params) do
    conn
    |> put_flash(:error, "You must be signed in to access this page")
    |> redirect(to: page_path(conn, :index))
  end
end
