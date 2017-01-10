defmodule Ccsp.Repo.Migrations.CreateChallenge do
  use Ecto.Migration

  def change do
    create table(:challenges) do
      add :name, :string
      add :content, :string

      timestamps()
    end

  end
end
