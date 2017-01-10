defmodule Ccsp.Api.ChallengeView do
  use Ccsp.Web, :view

  def render("index.json", %{challenges: challenges}) do
    %{data: render_many(challenges, Ccsp.Api.ChallengeView, "challenge.json")}
  end

  def render("show.json", %{challenge: challenge}) do
    %{data: render_one(challenge, Ccsp.Api.ChallengeView, "challenge.json")}
  end

  def render("challenge.json", %{challenge: challenge}) do
    %{id: challenge.id,
      name: challenge.name,
      content: challenge.content}
  end
end
