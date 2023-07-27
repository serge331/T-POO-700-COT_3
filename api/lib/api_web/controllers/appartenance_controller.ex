defmodule ApiWeb.AppartenanceController do
  use ApiWeb, :controller

  alias Api.Timemanager
  alias Api.Timemanager.Appartenance

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    appartenances = Timemanager.list_appartenances()
    render(conn, "index.json", appartenances: appartenances)
  end

  def get_app_with_user(conn , %{"user_id" => user_id})do
    appartenances = Timemanager.get_app_with_user(user_id)
    render(conn , "index.json" , appartenances: appartenances)
  end

  def get_app_with_team(conn , %{"team_id" => team_id})do
    appartenances = Timemanager.get_app_with_team(team_id)
    render(conn , "index.json" , appartenances: appartenances)
  end

  def create(conn, %{"team_id" => team_id , "user_id" => user_id}) do
    with {:ok, %Appartenance{} = appartenance} <- Timemanager.create_appartenance(team_id , user_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.appartenance_path(conn, :show, appartenance))
      |> render("show.json", appartenance: appartenance)
    end
  end

  def show(conn, %{"id" => id}) do
    appartenance = Timemanager.get_appartenance!(id)
    render(conn, "show.json", appartenance: appartenance)
  end

  def update(conn, %{"id" => id, "team_id" => team_id , "user_id" => user_id }) do
    appartenance = Timemanager.get_appartenance!(id)

    with {:ok, %Appartenance{} = appartenance} <- Timemanager.update_appartenance(appartenance, team_id , user_id) do
      render(conn, "show.json", appartenance: appartenance)
    end
  end

  def delete(conn, %{"id" => id}) do
    appartenance = Timemanager.get_appartenance!(id)

    with {:ok, %Appartenance{}} <- Timemanager.delete_appartenance(appartenance) do
      send_resp(conn, :no_content, "")
    end
  end
end
