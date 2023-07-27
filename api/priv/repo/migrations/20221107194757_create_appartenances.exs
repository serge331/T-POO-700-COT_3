defmodule Api.Repo.Migrations.CreateAppartenances do
  use Ecto.Migration

  def change do
    create table(:appartenances) do
      add :user_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:appartenances, [:user_id])
    create index(:appartenances, [:team_id])
  end
end
