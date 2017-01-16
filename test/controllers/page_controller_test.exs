defmodule Ccsp.PageControllerTest do
  use Ccsp.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Login"
  end

  test "GET /dashboard/challenges", %{conn: conn} do
    conn = get conn, "/dashboard/challenges"
    assert html_response(conn, 302) =~ "redirected"
  end
end
