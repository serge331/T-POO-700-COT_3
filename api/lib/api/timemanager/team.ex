defmodule Api.Timemanager.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :deleted, :boolean, default: false
    field :manager, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :manager, :deleted])
    |> validate_required([:name, :manager, :deleted])
    |> unique_constraint(:name)
  end
end
