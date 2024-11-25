defmodule BoardlyWeb.CardLive.AssignMemberComponent do
  use BoardlyWeb, :live_component

  alias Boardly.Cards

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        Assign Member
        <:subtitle>Select a member to assign to this card</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="assign-member-form"
        phx-target={@myself}
        phx-submit="save"
      >
        <.input
          field={@form[:user_id]}
          type="select"
          label="Select Member"
          options={Enum.map(@available_members, &{&1.email, &1.id})}
        />
        
        <:actions>
          <.button phx-disable-with="Saving...">
            Assign Member
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{card: card, available_members: members} = assigns, socket) do
    changeset = Cards.change_card_assignment(card)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:available_members, members)
     |> assign(:form, to_form(changeset))}
  end

  @impl true
  def handle_event("save", %{"card" => %{"user_id" => user_id}}, socket) do
    case Cards.assign_user_to_card(socket.assigns.card, user_id) do
      {:ok, _card} ->
        notify_parent({:member_assigned, socket.assigns.card.id})

        {:noreply,
         socket
         |> put_flash(:info, "Member assigned successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, _changeset} ->
        {:noreply,
         socket
         |> put_flash(:error, "Could not assign member")}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
