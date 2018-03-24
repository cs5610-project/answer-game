
defmodule Chatroom.Repo.Migrations.CreateQuests do
  use Ecto.Migration

  def change do
    create table(:quests) do
      add :question, :string, null: false
      add :topic, :string, null: false
      add :difficulty, :string, null: false
      add :answer, :string, null: false
      add :alternatives, {:array, :string}, null: false
 
      timestamps()
    end
  end
end

