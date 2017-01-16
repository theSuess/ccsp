defmodule Ccsp.TestcaseTest do
  use Ccsp.ModelCase

  alias Ccsp.Testcase

  @valid_attrs %{number: 42, input: "some content", output: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Testcase.changeset(%Testcase{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Testcase.changeset(%Testcase{}, @invalid_attrs)
    refute changeset.valid?
  end
end
