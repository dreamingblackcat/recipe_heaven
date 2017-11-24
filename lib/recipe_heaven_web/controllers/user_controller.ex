defmodule RecipeHeavenWeb.UserController do
  use RecipeHeavenWeb, :controller
  alias RecipeHeaven.{User, Repo}

  def show(conn, %{ "id" => id }) do
    user = Repo.get!(User, id)
    render conn, "show.html", user: user
  end
end
