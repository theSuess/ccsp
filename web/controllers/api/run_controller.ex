defmodule Ccsp.Api.RunController do
  use Ccsp.Web, :controller
  require Logger
  alias Ccsp.Glot
  alias Ccsp.Glot.Request
  def run(conn, %{"program" => program_params}) do
    req = %Request{
      files: [
        %Request.File{name: ("main." <> program_params["extension"]),
                      content: program_params["content"]}
      ],
      stdin: program_params["stdin"]
    }
    res = Glot.runprogramm(program_params["language"],req)
    render(conn, "response.json", response: res.body)
  end

  def test(conn, %{"challenge_id" => id, "program" => program_params}) do
    req = %Request{
      files: [
        %Request.File{name: ("main." <> program_params["extension"]),
                      content: program_params["content"]}
      ],
      stdin: program_params["stdin"]
    }
    res = Glot.runtestcases(program_params["language"],req,id)
    cor = length(Enum.filter(res,fn x -> x end))
    incor = length(res) - cor
    render(conn, "testresult.json", correct: cor, incorrect: incor)
  end
end
