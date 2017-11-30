defmodule RecipeHeavenWeb.RecipeController do
  use RecipeHeavenWeb, :controller
  alias RecipeHeaven.{Recipe, Repo}
  alias RecipeHeaven.Auth
  import Ecto.Query

  def index(conn, _params) do
    user_id = current_user(conn).id
    recipes = Repo.all(from recipe in Recipe, where: recipe.user_id == ^user_id)
    render(conn, "index.html", recipes: recipes)
  end

  def new(conn, _params) do
    changeset = Recipe.changeset(%Recipe{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{ "id" => id }) do
    recipe = Repo.get!(Recipe, id)
    render conn, "show.html", recipe: recipe
  end

  def create(conn, %{"recipe" => recipe_params }) do
    user_id = current_user(conn).id
    recipe_params = Map.put(recipe_params, "user_id", user_id)
    changeset = %Recipe{} |> Recipe.changeset(recipe_params)  

    case Repo.insert(changeset) do
      {:ok, recipe}         ->
        conn
        |> put_flash(:info, "Your recipe has been created!")
        |> redirect(to: recipe_path(conn, :show, recipe))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Error creating recipe")
        |> render("new.html", changeset: changeset)
    end 
  end

  defp current_user(conn) do
    Auth.Guardian.Plug.current_resource(conn)
  end
end
