defmodule RecipeHeavenWeb.Router do
  use RecipeHeavenWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RecipeHeavenWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    
    get "/signup", RegistrationController, :new
    post "/signup", RegistrationController, :create, as: :registration

    resources "/users", UserController, only: [:show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", RecipeHeavenWeb do
  #   pipe_through :api
  # end
end
