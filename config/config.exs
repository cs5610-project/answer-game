# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gameproject,
  ecto_repos: [Gameproject.Repo]

# Configures the endpoint
config :gameproject, GameprojectWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EYo5N/0fnWp9SobMuTCzp4ueX1/55e/puO82HFl86j1hRPjMRlBUNrAdDl1z37bU",
  render_errors: [view: GameprojectWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Gameproject.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"



# Add GitHub to your Überauth configuration
config :ueberauth, Ueberauth,
  # providers are who can user authenticate with for our application
  providers: [
    github: { Ueberauth.Strategy.Github, []}
  ]


# Update your provider configuration
config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")
