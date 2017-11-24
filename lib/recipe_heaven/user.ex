defmodule RecipeHeaven.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias RecipeHeaven.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end
end
