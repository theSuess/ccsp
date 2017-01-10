defmodule Ccsp.Repo.Migrations.CreateTestcase do
  use Ecto.Migration

  def change do
    create table(:testcases) do
      add :input, :string
      add :output, :string
      add :challenge_id, references(:challenges, on_delete: :nothing)

      timestamps()
    end
    create index(:testcases, [:challenge_id])

  end
end
