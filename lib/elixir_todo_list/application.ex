defmodule ElixirTodoList.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirTodoList.Repo,
      {Phoenix.PubSub, name: ElixirTodoList.PubSub},
      ElixirTodoListWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: ElixirTodoList.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    ElixirTodoListWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end


  