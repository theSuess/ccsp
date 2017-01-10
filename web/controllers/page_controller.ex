defmodule Ccsp.PageController do
  use Ccsp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def admin_index(conn, _params) do
    render conn, "admin.html"
  end
end
