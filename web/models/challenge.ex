defmodule Ccsp.Challenge do
  use Ccsp.Web, :model

  schema "challenges" do
    field :number, :integer
    field :name, :string
    field :content, :string
    has_many :testcases, Ccsp.Testcase

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:number,:name, :content])
    |> validate_required([:number,:name, :content])
    |> unique_constraint(:number)
  end

  def ordered(query) do
    from c in query,
      order_by: c.number
  end

  defp strip_unsafe_body(model, %{"body" => nil}) do
    model
  end

  defp strip_unsafe_body(model, %{"body" => body}) do
    {:safe, clean_body} = Phoenix.HTML.html_escape(body)
    model |> put_change(:body, clean_body)
  end

  defp strip_unsafe_body(model, _) do
    model
  end
end
