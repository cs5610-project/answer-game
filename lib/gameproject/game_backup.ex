defmodule Gameproject.GameBackup do
  use Agent

  # store a map from game name to backed up game state

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(name, game) do
    Agent.update __MODULE__, fn state ->
      Map.put(state, name, game)
    end
  end


  def load(name) do
    Agent.get __MODULE__, fn state ->
      Map.get(state, name)
    end
  end
end
