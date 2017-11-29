defmodule RecipeHeavenWeb.Plugs.RedirectSignedInUsers do
  import Plug.Conn
  use Phoenix.Controller, namespace: RecipeHeavenWeb

  def init(default) do
    default
  end

  def call(conn, _) do
    conn
    |> put_flash(:error, "You're already signed in")
    |> redirect(to: "/")
  end
end
