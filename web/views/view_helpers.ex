defmodule Ccsp.ViewHelpers do
  import Ccsp.Router.Helpers
  import Phoenix.HTML

  def current_user(conn), do: Guardian.Plug.current_resource(conn)
  def logged_in?(conn), do: Guardian.Plug.authenticated?(conn)
  def relhome(conn) do
    if logged_in?(conn) do
      dashboard_page_path(conn, :dashboard_index)
    else
      admin_page_path(conn,:admin_index)
    end
  end
  def markdown(body) do
    body
    |> Earmark.to_html
    |> raw
  end
end
