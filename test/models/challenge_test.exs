defmodule Ccsp.ChallengeTest do
  use Ccsp.ModelCase

  alias Ccsp.Challenge

  @valid_attrs %{number: 42, content: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Challenge.changeset(%Challenge{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Challenge.changeset(%Challenge{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "when the content includes a script tag" do
    changeset = Challenge.changeset(%Challenge{}, %{@valid_attrs | content: "Hello <script type='javascript'>alert('foo');</script>"})
    refute String.match? get_change(changeset, :content), ~r{<script>}
  end

  test "when the body includes an iframe tag" do
    changeset = Challenge.changeset(%Challenge{}, %{@valid_attrs | content: "Hello <iframe src='http://google.com'></iframe>"})
    refute String.match? get_change(changeset, :content), ~r{<iframe>}
  end

  test "body includes no stripped tags" do
    changeset = Challenge.changeset(%Challenge{}, @valid_attrs)
    assert get_change(changeset, :content) == @valid_attrs[:content]
  end
end
