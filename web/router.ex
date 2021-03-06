defmodule Border.Router do
  use Border.Web, :router

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

  scope "/", Border do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/create", PageController, :create
    get "/join", PageController, :join
    get "/game", PageController, :game
  end

  # Other scopes may use custom stacks.
  # scope "/api", Border do
  #   pipe_through :api
  # end
end
