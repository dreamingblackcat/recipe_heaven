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
    plug :fetch_session
    plug Guardian.Plug.Pipeline, module: RecipeHeaven.Auth.Guardian,
      error_handler: RecipeHeaven.Auth.AuthErrorHandler
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RecipeHeavenWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    
    get "/signup", RegistrationController, :new
    post "/signup", RegistrationController, :create, as: :registration

    scope "/users" do
      pipe_through :browser_auth # Use the default browser stack
      resources "/", UserController, only: [:show]
    end

    get "/signin", SessionController, :new 
    post "/signin", SessionController, :create
    delete "/signout/:id", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", RecipeHeavenWeb do
  #   pipe_through :api
  # end
end
