defmodule RecipeHeavenWeb.RegistrationController do
  use RecipeHeavenWeb, :controller
  alias RecipeHeaven.{User, Repo}
  alias RecipeHeaven.Auth

  plug RecipeHeavenWeb.Plugs.RedirectSignedInUsers

  def new(conn, _params) do
    changeset = User.registration_changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params }) do
    changeset = %User{} |> User.registration_changeset(user_params)  

    case Repo.insert(changeset) do
      {:ok, user}         ->
        conn
        |> Auth.Guardian.Plug.sign_in(user)
        |> put_flash(:info, "Hi! #{user.name}, you have successfully registered an account")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} -> 
        conn
        |> put_flash(:error, "Cannot register user due to error")
        |> render("new.html", changeset: changeset)
    end 
  end

  defp redirect_authenticated(conn, _) do
    conn
    |> put_flash(:error, "You're already signed in")
    |> redirect(to: "/")
  end
end
