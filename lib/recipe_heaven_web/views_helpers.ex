defmodule RecipeHeavenWeb.ViewHelpers do

  alias RecipeHeaven.Auth.Guardian

  def logged_in?(conn), do: !!current_user(conn)

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
