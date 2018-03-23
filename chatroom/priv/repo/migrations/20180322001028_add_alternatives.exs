defmodule Chatroom.Repo.Migrations.AddAlternatives do
  use Ecto.Migration

  def change do
     alter table("quests") do
     add :alternatives, {:array, :string}, null: false
end
  end
end
