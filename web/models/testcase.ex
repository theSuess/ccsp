defmodule Ccsp.Testcase do
  use Ccsp.Web, :model

  schema "testcases" do
    field :input, :string
    field :output, :string
    belongs_to :challenge, Ccsp.Challenge

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:input, :output])
    |> validate_required([:input, :output])
  end
end
