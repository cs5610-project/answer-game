defmodule Gameproject.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :message, :string
      add :name, :string

      timestamps()
    end

  end
end