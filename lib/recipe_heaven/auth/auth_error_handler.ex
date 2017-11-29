defmodule RecipeHeaven.Auth.AuthErrorHandler do
  use RecipeHeavenWeb, :controller
  alias RecipeHeavenWeb.Router.Helpers

  def auth_error(conn, {type, reason}, _opts) do
    conn
    |> put_flash(:error, "You're not authorized to perform this action")
    |> redirect(to: "/")
  end
end
