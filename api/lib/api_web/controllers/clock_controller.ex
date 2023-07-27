defmodule ApiWeb.ClockController do
  use ApiWeb, :controller

  alias Api.Timemanager
  alias Api.Timemanager.Clock

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    clocks = Timemanager.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"time" => time , "status" => status , "userID" => userID}) do
    with {:ok, %Clock{} = clock} <- Timemanager.create_clock(time , status , userID) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"userID" => id}) do
    clock = Timemanager.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"userID" => id, "time" => time , "status" => status}) do
    clock = Timemanager.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Timemanager.update_clock(clock, time , status) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"userID" => id}) do
    clock = Timemanager.get_clock!(id)

    with {:ok, %Clock{}} <- Timemanager.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
