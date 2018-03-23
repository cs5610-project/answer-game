defmodule Gameproject.Chatroom.Quest do
  use Ecto.Schema
  import Ecto.Changeset


  schema "quests" do
    field :alternative, {:array, :string}
    field :answer, :string
    field :difficulty, :string
    field :question, :string
    field :topic, :string

    timestamps()
  end

  @doc false
  def changeset(quest, attrs) do
    quest
    |> cast(attrs, [:answer, :difficulty, :question, :topic, :alternative])
    |> validate_required([:answer, :difficulty, :question, :topic, :alternative])
  end
end
