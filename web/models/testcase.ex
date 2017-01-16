defmodule Ccsp.Testcase do
  use Ccsp.Web, :model

  schema "testcases" do
    field :number, :integer
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
    |> cast(params, [:number,:input, :output])
    |> unique_constraint(:testcases, [:challenge_id,:number])
    |> validate_required([:number,:input, :output])
  end

  def ordered(query,id) do
    from t in query,
      where: t.challenge_id == ^id,
      order_by: t.number
  end
end
