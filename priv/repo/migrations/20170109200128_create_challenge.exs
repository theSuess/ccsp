defmodule Ccsp.Repo.Migrations.CreateChallenge do
  use Ecto.Migration

  def change do
    create table(:challenges) do
      add :number, :integer
      add :name, :string
      add :content, :text

      timestamps()
    end
    create unique_index(:challenges, [:number])
  end
end
