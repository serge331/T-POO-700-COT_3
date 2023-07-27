defmodule ApiWeb.JwtAuthPlug do 
    import Plug.Conn

    def init(opts), do: opts 

    def call(conn, _opts)do
        case Joken.Signer.verify(get_jwt_cookie(conn) , Joken.Signer.parse_config(:hs256)) do
            {:ok , %{"email" =>  email  , "id" => id , "role" => role , "username" => username}} ->
            conn |> success()
            {:error, :signature_error} ->
            conn |> forbidden
        end
    end

    defp get_jwt_cookie(conn) do
        
        list =  conn  |> Plug.Conn.get_req_header("session")
        case List.first(list) do 
            nil ->
            conn |> error
            val -> 
            val
            |> Plug.Conn.Cookies.decode 
            |> token(conn)
        end
    end

    defp token(%{"session_token" => jwt} , _conn), do: jwt

    defp error(_conn),do: ""

    defp success(conn) do
        conn
        |> put_status(201)
    end

    def forbidden(conn) do
        #unauthorized = %{unauthorized: "You can't access this ressource"}
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.json(%{unauthorized: "You can't access this ressource"})
        |> halt
    end

end