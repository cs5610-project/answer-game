defmodule GameprojectWeb.RoomChannel do
  use GameprojectWeb, :channel

  import Ecto.Query

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)

      game = Gameproject.GameBackup.load(name) || Gameproject.Chatroom.Game.load()

      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)

      {:ok, %{ "view" => Gameproject.Chatroom.Game.client_view(game) }, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end




  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    Gameproject.Chatroom.Message.changeset(%Gameproject.Chatroom.Message{}, payload) |> Gameproject.Repo.insert
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  def handle_info(:after_join, socket) do
    Gameproject.Chatroom.Message.get_messages()
    |> Enum.each(fn msg -> push(socket, "shout", %{
      name: msg.name,
      message: msg.message,
      }) end)
    {:noreply, socket} # :noreply
  end
end
