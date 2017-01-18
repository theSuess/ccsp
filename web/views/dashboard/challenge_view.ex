defmodule Ccsp.Dashboard.ChallengeView do
  use Ccsp.Web, :view
  def render("result.json", %{result: result}) do
    %{stdout: result.stdout,
      stderr: result.stderr,
      error: result.error}
  end
  def render("success.json", %{success: success}) do
    %{success: success}
  end
end
