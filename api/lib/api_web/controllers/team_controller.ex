defmodule ApiWeb.TeamController do
  use ApiWeb, :controller
  #import Plug.Conn
  alias Api.Timemanager
  alias Api.Timemanager.Team

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    teams = Timemanager.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"name" => name , "manager" => manager , "deleted" => deleted}) do
    with {:ok, %Team{} = team} <- Timemanager.create_team(name , manager , deleted) do
      conn
      |> put_status(:created)
      #|> put_resp_header("access-control-allow-origin" , "*")
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"teamID" => id}) do
    team = Timemanager.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"teamID" => id, "name" => name , "manager" => manager , "deleted" => deleted}) do
    team = Timemanager.get_team!(id)

    with {:ok, %Team{} = team} <- Timemanager.update_team(team, name , manager , deleted) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"teamID" => id}) do
    team = Timemanager.get_team!(id)

    with {:ok, %Team{}} <- Timemanager.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
