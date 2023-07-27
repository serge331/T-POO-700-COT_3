defmodule Api.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :manager, :string
      add :deleted, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:teams , [:name])
  end
end
