defmodule RecipeHeavenWeb.PageController do
  use RecipeHeavenWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
