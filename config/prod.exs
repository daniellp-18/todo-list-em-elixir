import Config

config :elixir_todo_list, ElixirTodoListWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000")
  ],
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE")
[
config :elixir_todo_list, ElixirTodoList.Repo,
  database: System.fetch_env!("DATABASE_PATH"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")]

