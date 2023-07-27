defmodule ApiWeb.AppartenanceView do
  use ApiWeb, :view
  alias ApiWeb.AppartenanceView

  def render("index.json", %{appartenances: appartenances}) do
    %{data: render_many(appartenances, AppartenanceView, "appartenance.json")}
  end

  def render("show.json", %{appartenance: appartenance}) do
    %{data: render_one(appartenance, AppartenanceView, "appartenance.json")}
  end

  def render("appartenance.json", %{appartenance: appartenance}) do
    %{
      id: appartenance.id,
      team_id: appartenance.team_id,
      user_id: appartenance.user_id
    }
  end
end
