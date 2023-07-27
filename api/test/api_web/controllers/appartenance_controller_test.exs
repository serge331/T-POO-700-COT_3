defmodule ApiWeb.AppartenanceControllerTest do
  use ApiWeb.ConnCase

  import Api.TimemanagerFixtures

  alias Api.Timemanager.Appartenance

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all appartenances", %{conn: conn} do
      conn = get(conn, Routes.appartenance_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create appartenance" do
    test "renders appartenance when data is valid", %{conn: conn} do
      conn = post(conn, Routes.appartenance_path(conn, :create), appartenance: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.appartenance_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.appartenance_path(conn, :create), appartenance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update appartenance" do
    setup [:create_appartenance]

    test "renders appartenance when data is valid", %{conn: conn, appartenance: %Appartenance{id: id} = appartenance} do
      conn = put(conn, Routes.appartenance_path(conn, :update, appartenance), appartenance: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.appartenance_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, appartenance: appartenance} do
      conn = put(conn, Routes.appartenance_path(conn, :update, appartenance), appartenance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete appartenance" do
    setup [:create_appartenance]

    test "deletes chosen appartenance", %{conn: conn, appartenance: appartenance} do
      conn = delete(conn, Routes.appartenance_path(conn, :delete, appartenance))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.appartenance_path(conn, :show, appartenance))
      end
    end
  end

  defp create_appartenance(_) do
    appartenance = appartenance_fixture()
    %{appartenance: appartenance}
  end
end
