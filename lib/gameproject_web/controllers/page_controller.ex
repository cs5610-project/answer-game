defmodule GameprojectWeb.PageController do
  use GameprojectWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def game(conn, params) do
    render conn, "game.html", game_name: params["game_name"]
  end

  def main(conn, _params) do
    render conn, "main.html"
  end
end
