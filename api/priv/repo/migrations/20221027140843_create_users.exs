defmodule Api.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :firstname, :string
      add :lastname, :string
      add :role, :string
      add :deleted, :boolean, default: false, null: false
      add :state, :boolean, default: false , null: false
      add :avatar, :string
      add :password, :string

      timestamps()

    end
    create unique_index(:users , [:email])
    create unique_index(:users , [:username])
  end
end
