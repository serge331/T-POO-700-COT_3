defmodule Api.Timemanager do
  @moduledoc """
  The Timemanager context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Timemanager.User


  def verify(email) do
    Repo.get_by(User , email: email)
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  def get_user1(email , username) do
    Repo.get_by(User , email: email, username: username)
  end

  def exist(username) do
    Repo.get_by(User , username: username)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(username, email, firstname, lastname, role,  deleted , state , avatar, password) do
    #Repo.insert(User.changeset(%User{} , %{username: username, email: email, firstname: firstname,  lastname: lastname, role: role, deleted: deleted , team: team}))
    %User{}
    |> User.changeset(%{username: username, email: email, firstname: firstname,  lastname: lastname, role: role, deleted: deleted , state: state , avatar: avatar, password: password})
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, username, email, firstname, lastname, role,  deleted  , state , avatar, password) do
    user
    |> User.changeset(%{username: username, email: email, firstname: firstname,  lastname: lastname, role: role, deleted: deleted , state: state, avatar: avatar, password: password})
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias Api.Timemanager.Clock

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clock{}, ...]

  """
  def list_clocks do
    Repo.all(Clock)
  end

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock!(id), do: Repo.get_by(Clock, user: id)

  @doc """
  Creates a clock.

  ## Examples

      iex> create_clock(%{field: value})
      {:ok, %Clock{}}

      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clock(time , status , userID) do
    %Clock{}
    |> Clock.changeset(%{time: time , status: status , user: userID})
    |> Repo.insert()
  end

  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clock(%Clock{} = clock, time , status) do
    clock
    |> Clock.changeset(%{time: time , status: status})
    |> Repo.update()
  end

  @doc """
  Deletes a clock.

  ## Examples

      iex> delete_clock(clock)
      {:ok, %Clock{}}

      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.

  ## Examples

      iex> change_clock(clock)
      %Ecto.Changeset{data: %Clock{}}

  """
  def change_clock(%Clock{} = clock, attrs \\ %{}) do
    Clock.changeset(clock, attrs)
  end

  alias Api.Timemanager.Workingtime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
  def list_workingtimes do
    Repo.all(Workingtime)
  end

  def time(id) do
    Repo.get_by(Workingtime , user: id)
  end

  @doc """
  Gets a single workingtime.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtime!(id), do: Repo.get!(Workingtime, id)

  @doc """
  Creates a workingtime.

  ## Examples

      iex> create_workingtime(%{field: value})
      {:ok, %Workingtime{}}

      iex> create_workingtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtime(start , end_ , userID) do
    %Workingtime{}
    |> Workingtime.changeset(%{start: start , end: end_ , user: userID})
    |> Repo.insert()
  end

  @doc """
  Updates a workingtime.

  ## Examples

      iex> update_workingtime(workingtime, %{field: new_value})
      {:ok, %Workingtime{}}

      iex> update_workingtime(workingtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtime(%Workingtime{} = workingtime, start , end_) do
    workingtime
    |> Workingtime.changeset(%{start: start , end: end_})
    |> Repo.update()
  end

  @doc """
  Deletes a workingtime.

  ## Examples

      iex> delete_workingtime(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtime changes.

  ## Examples

      iex> change_workingtime(workingtime)
      %Ecto.Changeset{data: %Workingtime{}}

  """
  def change_workingtime(%Workingtime{} = workingtime, attrs \\ %{}) do
    Workingtime.changeset(workingtime, attrs)
  end

  alias Api.Timemanager.Team

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team)
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(name , manager , deleted) do
    %Team{}
    |> Team.changeset(%{name: name , manager: manager , deleted: deleted})
    |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, name , manager , deleted ) do
    team
    |> Team.changeset(%{name: name , manager: manager , deleted: deleted})
    |> Repo.update()
  end

  @doc """
  Deletes a team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end


  alias Api.Timemanager.Appartenance

  @doc """
  Returns the list of appartenances.

  ## Examples

      iex> list_appartenances()
      [%Appartenance{}, ...]

  """
  def list_appartenances do
    Repo.all(Appartenance)
  end

  @doc """
  Gets a single appartenance.

  Raises `Ecto.NoResultsError` if the Appartenance does not exist.

  ## Examples

      iex> get_appartenance!(123)
      %Appartenance{}

      iex> get_appartenance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_appartenance!(id), do: Repo.get!(Appartenance, id)

  def get_app_with_user(user_id) do
    Repo.get_by(Appartenance , user_id: user_id)
  end

  def get_app_with_team(team_id) do
    query = from(Appartenance, where: [team_id: ^team_id])
    Repo.all(query)
  end

  @doc """
  Creates a appartenance.

  ## Examples

      iex> create_appartenance(%{field: value})
      {:ok, %Appartenance{}}

      iex> create_appartenance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_appartenance(team_id , user_id) do
    %Appartenance{}
    |> Appartenance.changeset(%{team_id: team_id , user_id: user_id})
    |> Repo.insert()
  end

  @doc """
  Updates a appartenance.

  ## Examples

      iex> update_appartenance(appartenance, %{field: new_value})
      {:ok, %Appartenance{}}

      iex> update_appartenance(appartenance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_appartenance(%Appartenance{} = appartenance, team_id , user_id) do
    appartenance
    |> Appartenance.changeset(%{team_id: team_id , user_id: user_id})
    |> Repo.update()
  end

  @doc """
  Deletes a appartenance.

  ## Examples

      iex> delete_appartenance(appartenance)
      {:ok, %Appartenance{}}

      iex> delete_appartenance(appartenance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_appartenance(%Appartenance{} = appartenance) do
    Repo.delete(appartenance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking appartenance changes.

  ## Examples

      iex> change_appartenance(appartenance)
      %Ecto.Changeset{data: %Appartenance{}}

  """
  def change_appartenance(%Appartenance{} = appartenance, attrs \\ %{}) do
    Appartenance.changeset(appartenance, attrs)
  end
end
