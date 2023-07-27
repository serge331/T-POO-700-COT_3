defmodule ApiWeb.CorsCus do 
    import Plug.Conn

    def init(opts), do: opts 

    def call(conn, _opts)do
    conn
    |> merge_resp_headers([{"access-control-allow-origin", "*"} , {"access-control-allow-credentials", "true"} , {"access-control-allow-headers", "session"} , {"access-control-expose-headers", "session"}])
    end
end