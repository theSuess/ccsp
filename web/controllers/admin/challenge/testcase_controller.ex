defmodule Ccsp.Admin.Challenge.TestcaseController do
  use Ccsp.Web, :controller
  import Ecto.Query

  alias Ccsp.Testcase
  alias Ccsp.Challenge

  def index(conn, %{"challenge_id" => id}) do
    testcases = Testcase
    |> Testcase.ordered(id)
    |> Repo.all()
    |> Repo.preload(:challenge)
    challenge = Repo.get!(Challenge,id)
    render(conn, :index, testcases: testcases, challenge: challenge)
  end

  def new(conn, %{"challenge_id" => id}) do
    changeset = Testcase.changeset(%Testcase{})
    challenge = Repo.get!(Challenge,id)
    render(conn, "new.html", challenge: challenge, changeset: changeset)
  end

  def create(conn, %{"challenge_id" => id,"testcase" => testcase_params}) do
    changeset = Testcase.changeset(%Testcase{challenge: Repo.get!(Challenge,id)}, testcase_params)

    case Repo.insert(changeset) do
      {:ok, testcase} ->
        conn
        |> put_flash(:info, "Testcase created successfully.")
        |> redirect(to: admin_challenge_testcase_path(conn, :index,testcase.challenge))
      {:error, changeset} ->
        challenge = Repo.get(Challenge,id)
        render(conn, "new.html", challenge: challenge, changeset: changeset)
    end
  end

  def show(conn, %{"challenge_id" => challenge_id,"id" => id}) do
    testcase = Repo.get!(Testcase, id) |> Repo.preload(:challenge)
    render(conn, "show.html", testcase: testcase)
  end

  def edit(conn, %{"id" => id}) do
    testcase = Repo.get!(Testcase, id) |> Repo.preload(:challenge)
    changeset = Testcase.changeset(testcase)
    render(conn, "edit.html", testcase: testcase, changeset: changeset)
  end

  def update(conn, %{"id" => id, "testcase" => testcase_params}) do
    testcase = Repo.get!(Testcase, id) |> Repo.preload(:challenge)
    changeset = Testcase.changeset(testcase, testcase_params)

    case Repo.update(changeset) do
      {:ok, testcase} ->
        conn
        |> put_flash(:info, "Testcase updated successfully.")
        |> redirect(to: admin_challenge_testcase_path(conn, :show, testcase.challenge,testcase))
      {:error, changeset} ->
        render(conn, "edit.html", testcase: testcase, changeset: changeset)
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
