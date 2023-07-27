defmodule Api.TimemanagerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.Timemanager` context.
  """

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        deleted: true,
        manager: "some manager",
        name: "some name"
      })
      |> Api.Timemanager.create_team()

    team
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        deleted: true,
        email: "some email",
        firstname: "some firstname",
        lastname: "some lastname",
        role: "some role",
        username: "some username"
      })
      |> Api.Timemanager.create_user()

    user
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2022-10-26 14:08:00]
      })
      |> Api.Timemanager.create_clock()

    clock
  end

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~N[2022-10-26 14:08:00],
        start: ~N[2022-10-26 14:08:00]
      })
      |> Api.Timemanager.create_workingtime()

    workingtime
  end

  @doc """
  Generate a appartenance.
  """
  def appartenance_fixture(attrs \\ %{}) do
    {:ok, appartenance} =
      attrs
      |> Enum.into(%{

      })
      |> Api.Timemanager.create_appartenance()

    appartenance
  end
end
