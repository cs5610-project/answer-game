defmodule Chatroom.Quest do
  use Ecto.Schema
  import Ecto.Changeset


  schema "quests" do
    field :answer, :string
    field :difficulty, :string
    field :question, :string
    field :topic, :string
    field :alternatives, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(quest, attrs) do
    quest
    |> cast(attrs, [:question, :topic, :difficulty, :answer, :alternatives])
    |> validate_required([:question, :topic, :difficulty, :answer, :alternatives])
  end
end
