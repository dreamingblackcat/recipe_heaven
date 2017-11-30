defmodule RecipeHeaven.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias RecipeHeaven.{Repo, User}

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_many :recipes, RecipeHeaven.Recipe

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 3, max: 60)
    |> hash_password
  end

  def find_and_confirm_password(%{"email" => email, "password" => password }) do
    user = Repo.get_by(User, email: email)

    cond do
      user && checkpw(password, user.password_hash) ->
        { :ok, user }
      user                                            ->
        { :error, :wrong_password }
      true                                            -> 
        dummy_checkpw()
        { :error, :not_found}
    end
    
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true,
        changes: %{password: password}} -> put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _                                 -> changeset
    end
  end

end
