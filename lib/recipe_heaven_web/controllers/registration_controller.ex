defmodule RecipeHeavenWeb.RegistrationController do
  use RecipeHeavenWeb, :controller
  alias RecipeHeaven.{User, Repo}

  def new(conn, _params) do
    changeset = User.registration_changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params }) do
    changeset = %User{} |> User.registration_changeset(user_params)  

    case Repo.insert(changeset) do
      {:ok, user}         ->
        conn
        |> put_flash(:info, "User with name #{user.name} successfully registered")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} -> 
        conn
        |> put_flash(:error, "Cannot register user due to error")
        |> render("new.html", changeset: changeset)
    end 
  end
end
