defmodule Gameproject.ChatroomTest do
  use Gameproject.DataCase

  alias Gameproject.Chatroom

  describe "messages" do
    alias Gameproject.Chatroom.Message

    @valid_attrs %{message: "some message", name: "some name"}
    @update_attrs %{message: "some updated message", name: "some updated name"}
    @invalid_attrs %{message: nil, name: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chatroom.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Chatroom.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Chatroom.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Chatroom.create_message(@valid_attrs)
      assert message.message == "some message"
      assert message.name == "some name"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chatroom.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, message} = Chatroom.update_message(message, @update_attrs)
      assert %Message{} = message
      assert message.message == "some updated message"
      assert message.name == "some updated name"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Chatroom.update_message(message, @invalid_attrs)
      assert message == Chatroom.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Chatroom.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chatroom.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Chatroom.change_message(message)
    end
  end

  describe "quests" do
    alias Gameproject.Chatroom.Quest

    @valid_attrs %{alternative: [], answer: "some answer", difficulty: "some difficulty", question: "some question", topic: "some topic"}
    @update_attrs %{alternative: [], answer: "some updated answer", difficulty: "some updated difficulty", question: "some updated question", topic: "some updated topic"}
    @invalid_attrs %{alternative: nil, answer: nil, difficulty: nil, question: nil, topic: nil}

    def quest_fixture(attrs \\ %{}) do
      {:ok, quest} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chatroom.create_quest()

      quest
    end

    test "list_quests/0 returns all quests" do
      quest = quest_fixture()
      assert Chatroom.list_quests() == [quest]
    end

    test "get_quest!/1 returns the quest with given id" do
      quest = quest_fixture()
      assert Chatroom.get_quest!(quest.id) == quest
    end

    test "create_quest/1 with valid data creates a quest" do
      assert {:ok, %Quest{} = quest} = Chatroom.create_quest(@valid_attrs)
      assert quest.alternative == []
      assert quest.answer == "some answer"
      assert quest.difficulty == "some difficulty"
      assert quest.question == "some question"
      assert quest.topic == "some topic"
    end

    test "create_quest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chatroom.create_quest(@invalid_attrs)
    end

    test "update_quest/2 with valid data updates the quest" do
      quest = quest_fixture()
      assert {:ok, quest} = Chatroom.update_quest(quest, @update_attrs)
      assert %Quest{} = quest
      assert quest.alternative == []
      assert quest.answer == "some updated answer"
      assert quest.difficulty == "some updated difficulty"
      assert quest.question == "some updated question"
      assert quest.topic == "some updated topic"
    end

    test "update_quest/2 with invalid data returns error changeset" do
      quest = quest_fixture()
      assert {:error, %Ecto.Changeset{}} = Chatroom.update_quest(quest, @invalid_attrs)
      assert quest == Chatroom.get_quest!(quest.id)
    end

    test "delete_quest/1 deletes the quest" do
      quest = quest_fixture()
      assert {:ok, %Quest{}} = Chatroom.delete_quest(quest)
      assert_raise Ecto.NoResultsError, fn -> Chatroom.get_quest!(quest.id) end
    end

    test "change_quest/1 returns a quest changeset" do
      quest = quest_fixture()
      assert %Ecto.Changeset{} = Chatroom.change_quest(quest)
    end
  end
end
