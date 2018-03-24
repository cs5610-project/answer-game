defmodule Gameproject.Repo.Migrations.AddGame do
  use Ecto.Migration

  def change do

   alter table(:messages) do
   add :game_name, :string
end
  end
end
