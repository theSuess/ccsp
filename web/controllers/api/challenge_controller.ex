defmodule Ccsp.Api.ChallengeController do
  use Ccsp.Web, :controller

  alias Ccsp.Challenge

  def index(conn, _params) do
    challenges = Repo.all(Challenge)
    render(conn, :index, challenges: challenges)
  end

  def new(conn, _params) do
    changeset = Challenge.changeset(%Challenge{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"challenge" => challenge_params}) do
    changeset = Challenge.changeset(%Challenge{}, challenge_params)

    case Repo.insert(changeset) do
      {:ok, challenge} ->
        conn
        |> put_status(:created)
        |> render("show.json", challenge: challenge)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Ccsp.ChangesetView, :error, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    challenge = Repo.get!(Challenge, id)
    render(conn, "show.json", challenge: challenge)
  end

  def update(conn, %{"id" => id, "challenge" => challenge_params}) do
    challenge = Repo.get!(Challenge, id)
    changeset = Challenge.changeset(challenge, challenge_params)

    case Repo.update(changeset) do
      {:ok, challenge} ->
        render(conn, "show.json", challenge: challenge)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Ccsp.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    challenge = Repo.get!(Challenge, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(challenge)

    send_resp(conn, :no_content, "")
  end
end
