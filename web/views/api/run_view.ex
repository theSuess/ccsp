defmodule Ccsp.Api.RunView do
  use Ccsp.Web, :view

  def render("response.json", %{response: response}) do
    %{stdout: response.stdout,
      stderr: response.stderr,
      error: response.error}
  end

  def render("testresult.json", %{correct: cor, incorrect: incor}) do
    %{correct: cor,
      incorrect: incor}
  end
end
