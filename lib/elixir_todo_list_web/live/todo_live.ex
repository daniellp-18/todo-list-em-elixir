defmodule ElixirTodoListWeb.TodoLive do
  use ElixirTodoListWeb, :live_view

  # =========================
  # Montagem inicial do LiveView
  # =========================
  @impl true
  def mount(_params, _session, socket) do
    tasks = [
      %{id: 1, title: "Comprar leite", completed: false},
      %{id: 2, title: "Aprender LiveView", completed: true}
    ]

    socket =
      assign(socket,
        tasks: tasks,
        new_task_title: "" # campo de texto começa vazio
      )

    {:ok, socket}
  end

  # =========================
  # Captura evento de digitação
  # =========================
  @impl true
  def handle_event("update_form", %{"title" => new_title}, socket) do
    {:noreply, assign(socket, new_task_title: new_title)}
  end

  # =========================
  # Captura envio do formulário
  # =========================
  @impl true
  def handle_event("save_task", %{"title" => title}, socket) do
    if String.trim(title) != "" do
      new_task = %{
        id: System.unique_integer([:positive]),
        title: title,
        completed: false
      }

      socket =
        socket
        |> update(:tasks, fn tasks -> tasks ++ [new_task] end)
        |> assign(:new_task_title, "")

      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  # =========================
  # Marcar/desmarcar tarefa como concluída
  # =========================
  @impl true
  def handle_event("toggle_task", %{"id" => id_str}, socket) do
    id = String.to_integer(id_str)

    socket =
      update(socket, :tasks, fn tasks ->
        Enum.map(tasks, fn task ->
          if task.id == id do
            Map.update!(task, :completed, &(!&1))
          else
            task
          end
        end)
      end)

    {:noreply, socket}
  end

  # =========================
  # Remover tarefa
  # =========================
  @impl true
  def handle_event("delete_task", %{"id" => id_str}, socket) do
    id = String.to_integer(id_str)

    socket =
      update(socket, :tasks, fn tasks ->
        Enum.reject(tasks, fn task -> task.id == id end)
      end)

    {:noreply, socket}
  end

  # =========================
  # Renderização da interface
  # =========================
  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full max-w-lg mx-auto mt-12 p-6 bg-white rounded-lg shadow-md">
      <h1 class="text-3xl font-bold mb-6 text-center text-gray-800">
        Minha Lista de Tarefas
      </h1>

      <%!-- --- FORMULÁRIO DE ENTRADA --- --%>
      <form phx-submit="save_task" phx-change="update_form" class="flex gap-2 mb-6">
        <input
          type="text"
          name="title"
          value={@new_task_title}
          placeholder="O que precisa ser feito?"
          class="flex-grow p-2 border rounded"
          autofocus
        />
        <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
          Adicionar
        </button>
      </form>

      <%!-- --- LISTA DE TAREFAS --- --%>
      <div class="mt-8">
        <ul id="task-list">
          <li :for={task <- @tasks} class="flex justify-between items-center p-3 border-b">
            <span
              class={if task.completed, do: "line-through text-gray-500", else: "text-gray-900"}
              phx-click="toggle_task"
              phx-value-id={task.id}
              style="cursor: pointer;"
            >
              <%= task.title %>
            </span>
            <button
              phx-click="delete_task"
              phx-value-id={task.id}
              class="px-2 py-1 text-sm text-red-600 hover:text-red-800"
            >
              Remover
            </button>
          </li>
        </ul>
      </div>
    </div>
    """
  end
end





