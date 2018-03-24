defmodule Gameproject.Chatroom.Message do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "messages" do
    field :message, :string
    field :name, :string
    field :game_name, :string
    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message, :name, :game_name])
    |> validate_required([:message, :name])
  end

  def get_messages(game_name) do
     IO.inspect(game_name)
     IO.inspect("lalala")
    Gameproject.Repo.all((from u in Gameproject.Chatroom.Message, where: u.game_name == ^game_name))
  end
end
