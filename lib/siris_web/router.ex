defmodule SirisWeb.Router do
  use SirisWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SirisWeb do
    pipe_through :browser

    get "/", RecipeController, :index
    resources "/recipes", RecipeController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SirisWeb do
  #   pipe_through :api
  # end
end
