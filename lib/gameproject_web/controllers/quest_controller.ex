defmodule GameprojectWeb.QuestController do
  use GameprojectWeb, :controller

  alias Gameproject.Chatroom
  alias Gameproject.Chatroom.Quest

  def index(conn, _params) do
    quests = Chatroom.list_quests()
    render(conn, "index.html", quests: quests)
  end

  def new(conn, _params) do
    changeset = Chatroom.change_quest(%Quest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"quest" => quest_params}) do
    case Chatroom.create_quest(quest_params) do
      {:ok, quest} ->
        conn
        |> put_flash(:info, "Quest created successfully.")
        |> redirect(to: quest_path(conn, :show, quest))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    quest = Chatroom.get_quest!(id)
    render(conn, "show.html", quest: quest)
  end

  def edit(conn, %{"id" => id}) do
    quest = Chatroom.get_quest!(id)
    changeset = Chatroom.change_quest(quest)
    render(conn, "edit.html", quest: quest, changeset: changeset)
  end

  def update(conn, %{"id" => id, "quest" => quest_params}) do
    quest = Chatroom.get_quest!(id)

    case Chatroom.update_quest(quest, quest_params) do
      {:ok, quest} ->
        conn
        |> put_flash(:info, "Quest updated successfully.")
        |> redirect(to: quest_path(conn, :show, quest))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", quest: quest, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    quest = Chatroom.get_quest!(id)
    {:ok, _quest} = Chatroom.delete_quest(quest)

    conn
    |> put_flash(:info, "Quest deleted successfully.")
    |> redirect(to: quest_path(conn, :index))
  end
end
