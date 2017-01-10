defmodule Ccsp.Router do
  use Ccsp.Web, :router

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

  pipeline :browser_admin do
    plug BasicAuth, use_config: {:ccsp, :admin_auth}
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: Todo.Token
    plug Guardian.Plug.LoadResource
  end

  scope "/", Ccsp do
    pipe_through :browser # Use the default browser stack
    resources "/sessions", SessionController, only: [:new,:create,:delete]
    get "/", PageController, :index
  end

  scope "/admin", as: :admin do
    pipe_through [:browser, :browser_admin]

    resources "/users", Ccsp.Admin.UserController
    resources "/challenges", Ccsp.Admin.ChallengeController
    resources "/testcases", Ccsp.TestcaseController
    get "/", Ccsp.PageController, :admin_index
  end

  scope "/dashboard", as: :dashboard do
    pipe_through [:browser, :browser_auth]
    get "/", Ccsp.PageController, :index
  end

  scope "/api", as: :api do
    pipe_through :api
    resources "/challenges", Ccsp.Api.ChallengeController, only: [:index]
  end
end
