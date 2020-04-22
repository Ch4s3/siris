defmodule SirisWeb.Router do
  use SirisWeb, :router
  import Phoenix.LiveView.Router
  import Phoenix.LiveDashboard.Router
  use Plug.ErrorHandler
  use Sentry.Plug
  import Plug.BasicAuth

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

  pipeline :admins_only do
    plug BasicAuth, use_config: {:siris, :auth_config}
  end

  if Mix.env() == :dev do
    scope "/", SirisWeb do
      pipe_through :browser
      live_dashboard "/dashboard"
    end
  else
    scope "/admin" do
      pipe_through [:browser, :admins_only]
      live_dashboard "/dashboard"
    end
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
