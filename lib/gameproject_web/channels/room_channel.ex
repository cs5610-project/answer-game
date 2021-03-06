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

      {:ok, %{"view" => game }, socket}
      #{:ok, socket}
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
    Gameproject.GameBackup.save(socket.assigns[:name],socket.assigns[:game])
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

 # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end


  


 def handle_in("user-click", %{"index" => index}, socket) do
     currState = socket.assigns[:game]
     name = socket.assigns[:name]
     IO.inspect("lalalal")
     gameState = Gameproject.Chatroom.Game.getQuestionDetails(currState, index)
     IO.inspect("fghkjd")
     socket = assign(socket, :game, gameState)
     Gameproject.GameBackup.save(name, gameState)
     {:reply, {:ok, %{ "view" => gameState}}, socket}
  end

  def handle_in("score-check", %{"question" => question}, socket) do
     currState = socket.assigns[:game]
     name = socket.assigns[:name]
    
     gameState = Gameproject.Chatroom.Game.getScoreCheck(currState, question)
     IO.inspect("abcde")
     socket = assign(socket, :game, gameState)
     Gameproject.GameBackup.save(name, gameState)
     {:reply, {:ok, %{ "view" => gameState}}, socket}
  end

  def handle_in("reset", %{}, socket) do
     currState = socket.assigns[:game]
     name = socket.assigns[:name]
     gameState = Gameproject.Chatroom.Game.load()
     socket = assign(socket, :game, gameState)
     Gameproject.GameBackup.save(name, gameState)
    {:reply, {:ok, %{"view" => gameState}}, socket}
end

 def handle_info(:after_join, socket) do
    Gameproject.Chatroom.Message.get_messages(socket.assigns[:name])
    |> Enum.each(fn msg -> push(socket, "shout", %{
      name: msg.name,
      message: msg.message,
      game_name: msg.game_name,
      }) end)
    {:noreply, socket} 
# :noreply
  end
end
