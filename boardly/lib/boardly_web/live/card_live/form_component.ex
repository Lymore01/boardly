defmodule BoardlyWeb.CardLive.FormComponent do
  use BoardlyWeb, :live_component

  alias Boardly.Cards

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>
          <%= if @action == :edit_card, do: "Edit card details", else: "Create a new card" %>
        </:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="card-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:due_date]} type="datetime-local" label="Due date" />
        
        <:actions>
          <.button phx-disable-with="Saving...">
            <%= if @action == :edit_card, do: "Update Card", else: "Create Card" %>
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{card: card} = assigns, socket) do
    changeset = Cards.change_card(card)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:form, to_form(changeset))}
  end

  @impl true
  def handle_event("validate", %{"card" => card_params}, socket) do
    changeset =
      socket.assigns.card
      |> Cards.change_card(card_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  @impl true
  def handle_event("save", %{"card" => card_params}, socket) do
    save_card(socket, socket.assigns.action, card_params)
  end

  defp save_card(socket, :edit_card, card_params) do
    case Cards.update_card(socket.assigns.card, card_params) do
      {:ok, card} ->
        notify_parent({:saved, card})

        {:noreply,
         socket
         |> put_flash(:info, "Card updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  defp save_card(socket, :new_card, card_params) do
    card_params = Map.put(card_params, "list_id", socket.assigns.list)

    case Cards.create_card(card_params) do
      {:ok, card} ->
        notify_parent({:saved, card})

        {:noreply,
         socket
         |> put_flash(:info, "Card created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
