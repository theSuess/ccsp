defmodule Ccsp.User do
  use Ccsp.Web, :model

  alias Ccsp.Repo
  alias Ccsp.Submission

  schema "users" do
    field :name, :string
    field :token, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :token])
    |> validate_required([:name, :token])
  end

  def has_submitted(user,challenge) do
    query = from s in Submission,
      where: s.challenge_id == ^challenge.id and s.user_id == ^user.id
    length(Repo.all(query)) >= 1
  end
end
