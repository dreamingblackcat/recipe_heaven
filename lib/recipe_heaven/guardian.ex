defmodule RecipeHeaven.Guardian do
  use Guardian, otp_app: :recipe_heaven
  alias RecipeHeaven.{Repo, User}

  def subject_for_token(user = %User{}, _claims) do
    {:ok, "User:" <> to_string(user.id)}
  end

  def subject_for_token(_, _) do
    {:error, :unknown_resource}
  end

  def resource_from_claims(%{"sub" => "User:" <> uid_str}) do
    try do
      case Integer.parse(uid_str) do
	{uid, ""} ->
	  {:ok, Repo.get!(User, uid)}
	_ ->
	  {:error, :invalid_id}
      end
      rescue
	Ecto.NoResultsError -> {:error, :no_result}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :invalid_claims}
  end 
 end
