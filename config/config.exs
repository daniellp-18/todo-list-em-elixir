import Config

# Endpoint Phoenix
config :elixir_todo_list, ElixirTodoListWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ElixirTodoListWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirTodoList.PubSub,
  live_view: [signing_salt: "CHANGE_ME"],
  server: true

# Banco de dados SQLite
config :elixir_todo_list, ElixirTodoList.Repo,
  database: "db/elixir_todo_list_dev.db",
  pool_size: 10

# Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# JSON
config :phoenix, :json_library, Jason

# Versões de Esbuild e Tailwind
config :esbuild, version: "0.25.0"
config :tailwind, version: "4.1.12"

# Importa configurações por ambiente
import_config "#{config_env()}.exs"
# no final do arquivo
import_config "#{config_env()}.exs"

