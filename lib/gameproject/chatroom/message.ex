defmodule Gameproject.Chatroom.Message do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "messages" do
    field :message, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message, :name])
    |> validate_required([:message, :name])
  end

  def get_messages(limit \\ 20) do
    Gameproject.Repo.all(Gameproject.Chatroom.Message, limit: limit)
  end
end
