defmodule Ccsp.User do
  use Ccsp.Web, :model

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
end
