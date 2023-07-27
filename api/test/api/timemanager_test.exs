defmodule Api.TimemanagerTest do
  use Api.DataCase

  alias Api.Timemanager

  describe "teams" do
    alias Api.Timemanager.Team

    import Api.TimemanagerFixtures

    @invalid_attrs %{deleted: nil, manager: nil, name: nil}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Timemanager.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Timemanager.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{deleted: true, manager: "some manager", name: "some name"}

      assert {:ok, %Team{} = team} = Timemanager.create_team(valid_attrs)
      assert team.deleted == true
      assert team.manager == "some manager"
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timemanager.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{deleted: false, manager: "some updated manager", name: "some updated name"}

      assert {:ok, %Team{} = team} = Timemanager.update_team(team, update_attrs)
      assert team.deleted == false
      assert team.manager == "some updated manager"
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Timemanager.update_team(team, @invalid_attrs)
      assert team == Timemanager.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Timemanager.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Timemanager.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Timemanager.change_team(team)
    end
  end

  describe "users" do
    alias Api.Timemanager.User

    import Api.TimemanagerFixtures

    @invalid_attrs %{deleted: nil, email: nil, firstname: nil, lastname: nil, role: nil, username: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Timemanager.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Timemanager.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{deleted: true, email: "some email", firstname: "some firstname", lastname: "some lastname", role: "some role", username: "some username"}

      assert {:ok, %User{} = user} = Timemanager.create_user(valid_attrs)
      assert user.deleted == true
      assert user.email == "some email"
      assert user.firstname == "some firstname"
      assert user.lastname == "some lastname"
      assert user.role == "some role"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timemanager.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{deleted: false, email: "some updated email", firstname: "some updated firstname", lastname: "some updated lastname", role: "some updated role", username: "some updated username"}

      assert {:ok, %User{} = user} = Timemanager.update_user(user, update_attrs)
      assert user.deleted == false
      assert user.email == "some updated email"
      assert user.firstname == "some updated firstname"
      assert user.lastname == "some updated lastname"
      assert user.role == "some updated role"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Timemanager.update_user(user, @invalid_attrs)
      assert user == Timemanager.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Timemanager.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Timemanager.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Timemanager.change_user(user)
    end
  end

  describe "clocks" do
    alias Api.Timemanager.Clock

    import Api.TimemanagerFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Timemanager.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Timemanager.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~N[2022-10-26 14:08:00]}

      assert {:ok, %Clock{} = clock} = Timemanager.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2022-10-26 14:08:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timemanager.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~N[2022-10-27 14:08:00]}

      assert {:ok, %Clock{} = clock} = Timemanager.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2022-10-27 14:08:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Timemanager.update_clock(clock, @invalid_attrs)
      assert clock == Timemanager.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Timemanager.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Timemanager.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Timemanager.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias Api.Timemanager.Workingtime

    import Api.TimemanagerFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      workingtime = workingtime_fixture()
      assert Timemanager.list_workingtimes() == [workingtime]
    end

    test "get_workingtime!/1 returns the workingtime with given id" do
      workingtime = workingtime_fixture()
      assert Timemanager.get_workingtime!(workingtime.id) == workingtime
    end

    test "create_workingtime/1 with valid data creates a workingtime" do
      valid_attrs = %{end: ~N[2022-10-26 14:08:00], start: ~N[2022-10-26 14:08:00]}

      assert {:ok, %Workingtime{} = workingtime} = Timemanager.create_workingtime(valid_attrs)
      assert workingtime.end == ~N[2022-10-26 14:08:00]
      assert workingtime.start == ~N[2022-10-26 14:08:00]
    end

    test "create_workingtime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timemanager.create_workingtime(@invalid_attrs)
    end

    test "update_workingtime/2 with valid data updates the workingtime" do
      workingtime = workingtime_fixture()
      update_attrs = %{end: ~N[2022-10-27 14:08:00], start: ~N[2022-10-27 14:08:00]}

      assert {:ok, %Workingtime{} = workingtime} = Timemanager.update_workingtime(workingtime, update_attrs)
      assert workingtime.end == ~N[2022-10-27 14:08:00]
      assert workingtime.start == ~N[2022-10-27 14:08:00]
    end

    test "update_workingtime/2 with invalid data returns error changeset" do
      workingtime = workingtime_fixture()
      assert {:error, %Ecto.Changeset{}} = Timemanager.update_workingtime(workingtime, @invalid_attrs)
      assert workingtime == Timemanager.get_workingtime!(workingtime.id)
    end

    test "delete_workingtime/1 deletes the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{}} = Timemanager.delete_workingtime(workingtime)
      assert_raise Ecto.NoResultsError, fn -> Timemanager.get_workingtime!(workingtime.id) end
    end

    test "change_workingtime/1 returns a workingtime changeset" do
      workingtime = workingtime_fixture()
      assert %Ecto.Changeset{} = Timemanager.change_workingtime(workingtime)
    end
  end

  describe "appartenances" do
    alias Api.Timemanager.Appartenance

    import Api.TimemanagerFixtures

    @invalid_attrs %{}

    test "list_appartenances/0 returns all appartenances" do
      appartenance = appartenance_fixture()
      assert Timemanager.list_appartenances() == [appartenance]
    end

    test "get_appartenance!/1 returns the appartenance with given id" do
      appartenance = appartenance_fixture()
      assert Timemanager.get_appartenance!(appartenance.id) == appartenance
    end

    test "create_appartenance/1 with valid data creates a appartenance" do
      valid_attrs = %{}

      assert {:ok, %Appartenance{} = appartenance} = Timemanager.create_appartenance(valid_attrs)
    end

    test "create_appartenance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timemanager.create_appartenance(@invalid_attrs)
    end

    test "update_appartenance/2 with valid data updates the appartenance" do
      appartenance = appartenance_fixture()
      update_attrs = %{}

      assert {:ok, %Appartenance{} = appartenance} = Timemanager.update_appartenance(appartenance, update_attrs)
    end

    test "update_appartenance/2 with invalid data returns error changeset" do
      appartenance = appartenance_fixture()
      assert {:error, %Ecto.Changeset{}} = Timemanager.update_appartenance(appartenance, @invalid_attrs)
      assert appartenance == Timemanager.get_appartenance!(appartenance.id)
    end

    test "delete_appartenance/1 deletes the appartenance" do
      appartenance = appartenance_fixture()
      assert {:ok, %Appartenance{}} = Timemanager.delete_appartenance(appartenance)
      assert_raise Ecto.NoResultsError, fn -> Timemanager.get_appartenance!(appartenance.id) end
    end

    test "change_appartenance/1 returns a appartenance changeset" do
      appartenance = appartenance_fixture()
      assert %Ecto.Changeset{} = Timemanager.change_appartenance(appartenance)
    end
  end
end
