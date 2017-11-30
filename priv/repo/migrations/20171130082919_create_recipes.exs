defmodule RecipeHeaven.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string
      add :description, :text
      add :ingredients, :text
      add :directions, :text
      add :prep_time, :integer
      add :cooking_time, :integer
      add :servings, :integer
      add :user_id, references(:users)

      timestamps()
    end

  end
end
