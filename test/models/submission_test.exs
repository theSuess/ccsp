defmodule Ccsp.SubmissionTest do
  use Ccsp.ModelCase

  alias Ccsp.Submission

  @valid_attrs %{code: "some content", extension: "some content", language: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Submission.changeset(%Submission{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Submission.changeset(%Submission{}, @invalid_attrs)
    refute changeset.valid?
  end
end
