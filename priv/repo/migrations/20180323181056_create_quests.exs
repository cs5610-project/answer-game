defmodule Gameproject.Repo.Migrations.CreateQuests do
  use Ecto.Migration

  def change do
    create table(:quests) do
      add :answer, :string
      add :difficulty, :string
      add :question, :string
      add :topic, :string
      add :alternative, {:array, :string}

      timestamps()
    end

  end
end
