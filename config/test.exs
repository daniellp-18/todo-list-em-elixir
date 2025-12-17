import Config
[
config :elixir_todo_list, ElixirTodoList.Repo,
  database: ":memory:",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10]
[
config :elixir_todo_list, ElixirTodoListWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "TEST_SECRET_KEY_BASE",
  server: false]

