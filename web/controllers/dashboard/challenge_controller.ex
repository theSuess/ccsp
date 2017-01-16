defmodule Ccsp.Dashboard.ChallengeController do
  use Ccsp.Web, :controller

  alias Ccsp.Challenge

  def index(conn, _params) do
    challenges = Repo.all(Challenge)
    render(conn, "index.html", challenges: challenges)
  end

  def show(conn, %{"id" => id}) do
    challenge = Repo.get!(Challenge, id)
    render(conn, "show.html", challenge: challenge)
  end

end
