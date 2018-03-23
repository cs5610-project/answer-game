defmodule GameprojectWeb.Router do
  use GameprojectWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GameprojectWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/main", PageController, :main
    get "/games/:game_name", PageController, :game

    resources "/users", UserController
    resources "/messages", MessageController
    resources "/quests", QuestController



    ## Routes for sessions ##
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  scope "/auth", GameprojectWeb do
    pipe_through :browser

    # the request function which is defined by the Ueberauth module
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", GameprojectWeb do
  #   pipe_through :api
  # end
end
