defmodule Ccsp.Dashboard.ChallengeController do
  use Ccsp.Web, :controller

  require Logger

  alias Ccsp.Challenge
  alias Ccsp.Submission
  alias Ccsp.Glot
  alias Ccsp.Glot.Request

  def index(conn, _params) do
    challenges = Challenge
    |> Challenge.ordered()
    |> Repo.all()
    render(conn, "index.html", challenges: challenges)
  end

  def show(conn, %{"id" => id}) do
    challenge = Repo.get!(Challenge, id)
    render(conn, "show.html", challenge: challenge)
  end

  def submit(conn, %{"challenge_id" => id,"program" => program_params}) do
    user = Guardian.Plug.current_resource(conn)
    req = %Request{
      files: [
        %Request.File{name: ("main." <> program_params["extension"]),
                      content: program_params["content"]}
      ],
      stdin: program_params["stdin"]
    }
    res = Glot.runtestcases(program_params["language"],req,id)
    case Enum.all?(res) do
      true ->
        {cid,_} = Integer.parse id
        changeset = Submission.changeset(%Submission{user_id: user.id,
                                                     challenge_id: cid,
                                                     code: program_params["content"],
                                                     language: program_params["language"],
                                                     filename: "main." <>program_params["extension"]})
        case Repo.insert(changeset) do
          {:ok, challenge} ->
            render(conn, "success.json", success: true)
          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render("success.json", success: false)
        end
      false ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("success.json", success: false)
    end
  end
end
