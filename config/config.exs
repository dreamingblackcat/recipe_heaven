# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :recipe_heaven,
  ecto_repos: [RecipeHeaven.Repo]

# Configures the endpoint
config :recipe_heaven, RecipeHeavenWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fL2RY4yz5WR54EWe+RBWVF4pEN8Q6hp4sjeo0kvdSkIlDCzO9NCE9NIh4l4YXaFh",
  render_errors: [view: RecipeHeavenWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RecipeHeaven.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :recipe_heaven, RecipeHeaven.Guardian,
  issuer: "recipe_heaven",
  secret_key: "rk/gqkHeggqTPN2VfJgqv4BU3017LWzcwbilnFJFcqgvC4lm9sYK7hMpC2f6BHba"
  #allowed_algos: ["HS512"], # optional
  #verify_module: Guardian.JWT,  # optional
  #ttl: { 30, :days },
  #verify_issuer: true, # optional

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
