defmodule ElixirTodoListWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :elixir_todo_list

  @session_options [
    store: :cookie,
    key: "_elixir_todo_list_key",
    signing_salt: "MfCl45H1",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  plug Plug.Static,
    at: "/",
    from: :elixir_todo_list,
    gzip: false,
    only: ElixirTodoListWeb.static_paths()

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug ElixirTodoListWeb.Router
end
