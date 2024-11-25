defmodule BoardlyWeb.ListLive.FormComponent do
  use BoardlyWeb, :live_component

  alias Boardly.Lists

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>
          <%= if @action == :edit_list, do: "Edit list details", else: "Create a new list" %>
        </:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="list-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="List Name" />
        
        <:actions>
          <.button phx-disable-with="Saving...">
            <%= if @action == :edit_list, do: "Update List", else: "Create List" %>
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{list: list} = assigns, socket) do
    changeset = Lists.change_list(list)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"list" => list_params}, socket) do
    changeset =
      socket.assigns.list
      |> Lists.change_list(list_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"list" => list_params}, socket) do
    save_list(socket, socket.assigns.action, list_params)
  end

  defp save_list(socket, :edit_list, list_params) do
    case Lists.update_list(socket.assigns.list, list_params) do
      {:ok, list} ->
        notify_parent({:saved, list})

        {:noreply,
         socket
         |> put_flash(:info, "List updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_list(socket, :new_list, list_params) do
    case Lists.create_list(list_params) do
      {:ok, list} ->
        notify_parent({:saved, list})

        {:noreply,
         socket
         |> put_flash(:info, "List created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
