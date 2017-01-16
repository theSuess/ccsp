defmodule Ccsp.Api.RunView do
  use Ccsp.Web, :view

  def render("response.json", %{response: response}) do
    %{stdout: response.stdout,
      stderr: response.stderr,
      error: response.error}
  end
end
