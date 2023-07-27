defmodule Api.Timemanager.Appartenance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appartenances" do

    field :user_id, :id
    field :team_id, :id

    timestamps()
  end

  @doc false
  def changeset(appartenance, attrs) do
    appartenance
    |> cast(attrs, [:team_id , :user_id])
    |> validate_required([:team_id , :user_id])
  end
end
