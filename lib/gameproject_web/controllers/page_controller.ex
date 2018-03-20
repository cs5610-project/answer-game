defmodule GameprojectWeb.PageController do
  use GameprojectWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
