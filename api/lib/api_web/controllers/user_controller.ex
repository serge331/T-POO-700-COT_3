defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Timemanager
  alias Api.Timemanager.User

  action_fallback ApiWeb.FallbackController

  def login(conn , %{"email" => email , "password" => password })do
    case Timemanager.verify(email) do
    nil ->
     conn
    |> put_status(200)
    |> json(%{incorrect: "Vos identifiant ne sont pas corrects"})
    user ->
      case user.state do
        false -> 
          conn
          |> put_status(200)
          |> json(%{incorrect: "utilisateur inactif"})
        true ->
        case Bcrypt.verify_pass(password , user.password) do
          true -> 
          session = Joken.Signer.sign(%{"id" => user.id , "email" => user.email , "username" => user.username , "role" => user.role}, Joken.Signer.parse_config(:hs256))
          conn
          |> put_status(202)
          |> put_resp_cookie("session_token" , List.last(Tuple.to_list(session)) )
          |> json(%{id: user.id , email: user.email , username: user.username , role: user.role , session_token: List.last(Tuple.to_list(session)) })
          false ->
          conn
          |> put_status(200)
          |> json(%{incorrect: "Vos identifiant ne sont pas corrects"})
          end
      end
        
    end
  end

  def index_(conn, _params) do
    users = Timemanager.list_users
    render(conn, "index.json", users: users)
  end

  def exist(conn , %{"username" => username}) do
    case Timemanager.exist(username) do
      nil ->
        conn |> json(%{exist: false})
      user -> 
        conn |> render("show.json" , user: user)
    end
  end

  def index(conn, %{"email" => email , "username" =>username}) do
    user = Timemanager.get_user1(email , username)
    render(conn, "show.json", user: user)
  end

  def create(conn, %{"username" => username , "email" => email , "firstname" => firstname , "lastname" => lastname , "role" => role , "deleted" => deleted  , "state" => state , "avatar" => avatar, "password" => password}) do
    with {:ok, %User{} = user} <- Timemanager.create_user(username , email , firstname , lastname , role , deleted , state , avatar, password) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"userID" => id}) do
    user = Timemanager.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"userID" => id , "username" => username , "email" => email , "firstname" => firstname , "lastname" => lastname , "role" => role , "deleted" => deleted , "state" => state , "avatar" => avatar, "password" => password}) do
    user = Timemanager.get_user!(id)

    with {:ok, %User{} = user} <- Timemanager.update_user(user, username , email , firstname , lastname , role , deleted , state , avatar, password) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"userID" => id}) do
    user = Timemanager.get_user!(id)

    with {:ok, %User{}} <- Timemanager.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
