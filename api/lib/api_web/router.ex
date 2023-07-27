defmodule ApiWeb.Router do
  use ApiWeb, :router

  alias ApiWeb.JwtAuthPlug
  #alias ApiWeb.CorsCus

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ApiWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    #plug CorsCus
    #plug Corsica, origins: "*"
  end

  pipeline :authenticate do
    plug JwtAuthPlug
    

  end

  scope "/", ApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api/login", ApiWeb do
    pipe_through :api
    post "/" , UserController , :login
  end

  scope "/api/users", ApiWeb do
    pipe_through :api
    post "/", UserController , :create
  end

  # Other scopes may use custom stacks.
   scope "/api", ApiWeb do
     pipe_through [:api]
     get "/user/exist/:username" , UserController , :exist
     get "/users/all" , UserController , :index_
     get "/users/" , UserController , :index
     get "/users/:userID" , UserController , :show
     put "/users/:userID", UserController , :update
     delete "/users/:userID", UserController, :delete

     get "/workingtimes" , WorkingtimeController , :index
     get "/workingtimes/:userID/:id" , WorkingtimeController , :show
     post "/workingtimes/:userID", WorkingtimeController , :create
     put "/workingtimes/:id", WorkingtimeController , :update
     delete "/workingtimes/:id", WorkingtimeController, :delete

     get "/clocks/:userID" , ClockController , :show
     post "/clocks/:userID" , ClockController , :create

     get "/teams" , TeamController , :index
     get "/teams/:name" , TeamController , :select
     get "/teams/:teamID" , TeamController , :show
     post "/teams", TeamController , :create
     put "/teams/:teamID", TeamController , :update
     delete "/teams/:teamID", TeamController, :delete

     resources "/team_content", AppartenanceController #, only: [:index, :show]
     get "/team_content/user/:user_id" , AppartenanceController , :get_app_with_user
     get "/team_content/team/:team_id" , AppartenanceController , :get_app_with_team
   end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
