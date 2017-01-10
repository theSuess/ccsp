defmodule Ccsp.TestcaseController do
  use Ccsp.Web, :controller

  alias Ccsp.Testcase

  def index(conn, _params) do
    testcases = Repo.all(Testcase)
    render(conn, "index.json", testcases: testcases)
  end

  def create(conn, %{"testcase" => testcase_params}) do
    changeset = Testcase.changeset(%Testcase{}, testcase_params)

    case Repo.insert(changeset) do
      {:ok, testcase} ->
        conn
        |> put_status(:created)
        |> render("show.json", testcase: testcase)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Ccsp.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    testcase = Repo.get!(Testcase, id)
    render(conn, "show.json", testcase: testcase)
  end

  def update(conn, %{"id" => id, "testcase" => testcase_params}) do
    testcase = Repo.get!(Testcase, id)
    changeset = Testcase.changeset(testcase, testcase_params)

    case Repo.update(changeset) do
      {:ok, testcase} ->
        render(conn, "show.json", testcase: testcase)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Ccsp.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    testcase = Repo.get!(Testcase, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(testcase)

    send_resp(conn, :no_content, "")
  end
end
