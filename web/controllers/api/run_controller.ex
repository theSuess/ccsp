defmodule Ccsp.Api.RunController do
  use Ccsp.Web, :controller
  require Logger
  alias Ccsp.Glot
  alias Ccsp.Glot.Request
  def run(conn, %{"program" => program_params}) do
    req = %Request{
      files: [
        %Request.Files{name: ("main." <> program_params["extension"]) , content: program_params["content"]}
      ]
    }
    res = Glot.runprogramm(program_params["language"],req)
    render(conn, "response.json", response: res.body)
  end
end
