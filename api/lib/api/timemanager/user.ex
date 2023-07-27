defmodule Api.Timemanager.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :deleted, :boolean, default: false
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :role, :string
    field :username, :string
    field :state, :boolean, default: false
    field :avatar, :string
    field :password, :string

    timestamps()
  end



  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :firstname, :lastname, :role, :deleted , :state , :avatar , :password])
    |> validate_required([:username, :email, :firstname, :lastname, :role, :deleted , :state , :avatar , :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_length(:password , min: 8)

  end
end
