defmodule Ccsp.UserControllerTest do
  use Ccsp.ConnCase

  alias Ccsp.User
  @valid_attrs %{name: "some content", token: "some content"}
  @invalid_attrs %{}

  def with_auth(conn) do
    conn
    |> put_req_header("authorization", "Basic " <> Base.encode64("admin:admin"))
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get with_auth(conn), admin_user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing users"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get with_auth(conn), admin_user_path(conn, :new)
    assert html_response(conn, 200) =~ "New user"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post with_auth(conn), admin_user_path(conn, :create), user: @valid_attrs
    assert redirected_to(conn) == admin_user_path(conn, :index)
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post with_auth(conn), admin_user_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "New user"
  end

  test "shows chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = get with_auth(conn), admin_user_path(conn, :show, user)
    assert html_response(conn, 200) =~ "Show user"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get with_auth(conn), admin_user_path(conn,:show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = get with_auth(conn), admin_user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put with_auth(conn), admin_user_path(conn, :update, user), user: @valid_attrs
    assert redirected_to(conn) == admin_user_path(conn, :show, user)
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put with_auth(conn), admin_user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "deletes chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = delete with_auth(conn), admin_user_path(conn, :delete, user)
    assert redirected_to(conn) == admin_user_path(conn, :index)
    refute Repo.get(User, user.id)
  end
end
