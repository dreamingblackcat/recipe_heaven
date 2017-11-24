defmodule RecipeHeavenWeb.SessionController do
  use RecipeHeavenWeb, :controller
  alias RecipeHeaven.User

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => login_params}) do
    case User.find_and_confirm_password(login_params) do 
      {:ok, user} ->
        conn
        |> RecipeHeaven.Guardian.Plug.sign_in(user)
        |> put_flash(:info, "You are signed in now!")
        |> redirect(to: user_path(conn, :show, user.id))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Sorry, we cannot find a user with that email and password combination!")
        |> render("new.html")
    end
  end


  def delete(conn, _) do
    conn
    |> RecipeHeaven.Guardian.Plug.sign_out()
    |> put_flash(:info, "You're singed out now!")
    |> redirect(to: "/signin") 
  end
end
