use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :chatroom, ChatroomWeb.Endpoint,
  secret_key_base: "aojU/apG8QW9ez1HbssL7MeXNRgrKHCXwEchG6vS6v/PmaEcwPxFSBR6Ddw88Z2d"

# Configure your database
config :chatroom, Chatroom.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "chatroom_prod",
  pool_size: 15
