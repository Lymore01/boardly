defmodule BoardlyWeb.CardLive.Show do
  use BoardlyWeb, :live_view

  alias Boardly.Cards

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:card, Cards.get_card!(id))}
  end

  @impl true
  def handle_event("unassign_user", _, socket) do
    case Cards.unassign_user(socket.assigns.card) do
      {:ok, card} ->
        {:noreply,
         socket
         |> assign(:card, Cards.get_card!(card.id))
         |> put_flash(:info, "User unassigned successfully")}

      {:error, _changeset} ->
        {:noreply,
         socket
         |> put_flash(:error, "Could not unassign user")}
    end
  end

  defp page_title(:show), do: "Show Card"
  defp page_title(:edit), do: "Edit Card"
end
