defmodule GameprojectWeb.QuestControllerTest do
  use GameprojectWeb.ConnCase

  alias Gameproject.Chatroom

  @create_attrs %{alternative: [], answer: "some answer", difficulty: "some difficulty", question: "some question", topic: "some topic"}
  @update_attrs %{alternative: [], answer: "some updated answer", difficulty: "some updated difficulty", question: "some updated question", topic: "some updated topic"}
  @invalid_attrs %{alternative: nil, answer: nil, difficulty: nil, question: nil, topic: nil}

  def fixture(:quest) do
    {:ok, quest} = Chatroom.create_quest(@create_attrs)
    quest
  end

  describe "index" do
    test "lists all quests", %{conn: conn} do
      conn = get conn, quest_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Quests"
    end
  end

  describe "new quest" do
    test "renders form", %{conn: conn} do
      conn = get conn, quest_path(conn, :new)
      assert html_response(conn, 200) =~ "New Quest"
    end
  end

  describe "create quest" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, quest_path(conn, :create), quest: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == quest_path(conn, :show, id)

      conn = get conn, quest_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Quest"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, quest_path(conn, :create), quest: @invalid_attrs
      assert html_response(conn, 200) =~ "New Quest"
    end
  end

  describe "edit quest" do
    setup [:create_quest]

    test "renders form for editing chosen quest", %{conn: conn, quest: quest} do
      conn = get conn, quest_path(conn, :edit, quest)
      assert html_response(conn, 200) =~ "Edit Quest"
    end
  end

  describe "update quest" do
    setup [:create_quest]

    test "redirects when data is valid", %{conn: conn, quest: quest} do
      conn = put conn, quest_path(conn, :update, quest), quest: @update_attrs
      assert redirected_to(conn) == quest_path(conn, :show, quest)

      conn = get conn, quest_path(conn, :show, quest)
      assert html_response(conn, 200) =~ ""
    end

    test "renders errors when data is invalid", %{conn: conn, quest: quest} do
      conn = put conn, quest_path(conn, :update, quest), quest: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Quest"
    end
  end

  describe "delete quest" do
    setup [:create_quest]

    test "deletes chosen quest", %{conn: conn, quest: quest} do
      conn = delete conn, quest_path(conn, :delete, quest)
      assert redirected_to(conn) == quest_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, quest_path(conn, :show, quest)
      end
    end
  end

  defp create_quest(_) do
    quest = fixture(:quest)
    {:ok, quest: quest}
  end
end
