defmodule RecipeHeavenWeb.UserController do
  use RecipeHeavenWeb, :controller
  alias RecipeHeaven.{User, Repo}

  def show(conn, %{ "id" => id }) do
    user = Repo.get!(User, id)
    conn
    |> render "show.html", user: user
  end
end
