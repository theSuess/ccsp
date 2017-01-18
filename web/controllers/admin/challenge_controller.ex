defmodule Ccsp.Admin.ChallengeController do
  use Ccsp.Web, :controller

  alias Ccsp.Challenge

  def index(conn, _params) do
    challenges = Challenge
    |> Challenge.ordered()
    |> Repo.all()
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
        |> put_flash(:info, "Challenge created successfully.")
        |> redirect(to: admin_challenge_path(conn, :show, challenge))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    challenge = Repo.get!(Challenge, id)
    render(conn, "show.html", challenge: challenge)
  end

  def edit(conn, %{"id" => id}) do
    challenge = Repo.get!(Challenge, id)
    changeset = Challenge.changeset(challenge)
    render(conn, "edit.html", challenge: challenge, changeset: changeset)
  end

  def update(conn, %{"id" => id, "challenge" => challenge_params}) do
    challenge = Repo.get!(Challenge, id)
    changeset = Challenge.changeset(challenge, challenge_params)

    case Repo.update(changeset) do
      {:ok, challenge} ->
        conn
        |> put_flash(:info, "Challenge updated successfully.")
        |> redirect(to: admin_challenge_path(conn, :show, challenge))
      {:error, changeset} ->
        render(conn, "edit.html", challenge: challenge, changeset: changeset)
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
