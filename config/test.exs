use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gameproject, GameprojectWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :gameproject, Gameproject.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "gamer",
  password: "gamer",
  database: "gameproject_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
