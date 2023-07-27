defmodule ApiWeb.WorkingtimeController do
  use ApiWeb, :controller

  alias Api.Timemanager
  alias Api.Timemanager.Workingtime

  action_fallback ApiWeb.FallbackController

  def index(conn , _params) do
    workingtimes = Timemanager.list_workingtimes
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{ "end" => end_ , "start" => start ,  "userID" => userID}) do
    with {:ok, %Workingtime{} = workingtime} <- Timemanager.create_workingtime(start , end_ , userID) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :create, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"userID" => userID , "id" => id }) do
    workingtime = Timemanager.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "start" => start , "end" => end_}) do
    workingtime = Timemanager.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Timemanager.update_workingtime(workingtime, start , end_) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Timemanager.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Timemanager.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
