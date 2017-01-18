defmodule Ccsp.Submission do
  use Ccsp.Web, :model

  schema "submissions" do
    field :code, :string
    field :language, :string
    field :filename, :string
    belongs_to :challenge, Ccsp.Challenge
    belongs_to :user, Ccsp.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:code, :language, :filename, :user_id, :challenge_id])
    |> validate_required([:code, :language, :filename, :user_id, :challenge_id])
  end
end
