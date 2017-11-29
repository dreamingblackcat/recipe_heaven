defmodule RecipeHeavenWeb.Router do
  use RecipeHeavenWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.Pipeline, module: RecipeHeaven.Auth.Guardian,
      error_handler: RecipeHeaven.Auth.AuthErrorHandler
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :no_login_user do
    plug Guardian.Plug.Pipeline, module: RecipeHeaven.Auth.Guardian,
      error_handler: RecipeHeaven.Auth.AuthErrorHandler
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource, allow_blank: true
    plug Guardian.Plug.EnsureNotAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RecipeHeavenWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    scope "/" do 
      pipe_through :no_login_user # Use the default browser stack

      get "/signup", RegistrationController, :new
      post "/signup", RegistrationController, :create, as: :registration
      get "/signin", SessionController, :new 
      post "/signin", SessionController, :create
    end

    scope "/users" do
      pipe_through :browser_auth

      resources "/", UserController, only: [:show]

      delete "/signout/:id", SessionController, :delete
    end

  end

  # Other scopes may use custom stacks.
  # scope "/api", RecipeHeavenWeb do
  #   pipe_through :api
  # end
end
