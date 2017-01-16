defmodule Ccsp.Repo.Migrations.CreateTestcase do
  use Ecto.Migration

  def change do
    create table(:testcases) do
      add :number, :integer
      add :input, :string
      add :output, :string
      add :challenge_id, references(:challenges, on_delete: :delete_all)

      timestamps()
    end
    create index(:testcases, [:challenge_id])
    create unique_index(:testcases, [:challenge_id,:number])

  end
end
