defmodule RecipeHeaven.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  alias RecipeHeaven.Recipe


  schema "recipes" do
    field :cooking_time, :integer
    field :description,  :string
    field :directions,   { :array, :string }
    field :ingredients,  { :array, :string }
    field :name,         :string
    field :prep_time,    :integer
    field :servings,     :integer
    belongs_to :user,    RecipeHeaven.User

    timestamps()
  end

  @doc false
  def changeset(%Recipe{} = recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :description, :ingredients, :directions, :prep_time, :cooking_time, :servings, :user_id])
    |> validate_required([:name, :description, :ingredients, :directions, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
