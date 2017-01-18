defmodule Ccsp.Repo.Migrations.CreateSubmission do
  use Ecto.Migration

  def change do
    create table(:submissions) do
      add :code, :string
      add :language, :string
      add :filename, :string
      add :challenge_id, references(:challenges, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
    create index(:submissions, [:challenge_id])
    create index(:submissions, [:user_id])

  end
end
