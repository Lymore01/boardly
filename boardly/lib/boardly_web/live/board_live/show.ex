defmodule BoardlyWeb.BoardLive.Show do
  use BoardlyWeb, :live_view

  alias Boardly.Boards
  alias Boardly.Lists
  alias Boardly.Lists.List
  alias Boardly.Cards
  alias Boardly.Cards.Card
  alias Boardly.Accounts.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id, "list_id" => list_id, "card_id" => card_id}, _, socket) do
    board = Boards.get_board_with_lists(id)
    list = Lists.get_list_with_cards(list_id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:board, board)
     |> assign(:lists, board.lists)
     |> assign(:list, list)
     |> assign(:card, Cards.get_card!(card_id))
     |> assign(:listId, list_id)
     |> assign(:cards, list.cards)}
  end

  def handle_params(%{"id" => id, "list_id" => list_id}, _, socket) do
    board = Boards.get_board_with_lists(id)
    list = Lists.get_list_with_cards(list_id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:board, board)
     |> assign(:lists, board.lists)
     |> assign(:list, list)
     |> assign(:card, %Card{})
     |> assign(:listId, list_id)
     |> assign(:cards, list.cards)}
  end

  def handle_params(%{"id" => id}, _, socket) do
    board = Boards.get_board_with_lists(id)
    members = Boards.get_board_with_users(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:board, board)
     |> assign(:lists, board.lists)
     |> assign(:members, members.users)
     |> assign(:list, %List{})
     |> assign(:card, %Card{})
     |> assign(:user, %User{})
     |> assign(:cards, [])}
  end

  def handle_event("remove_card", %{"card_id" => card_id}, socket) do
    card = Cards.get_card!(card_id)

    case Cards.delete_card(card) do
      {:ok, _} ->
        updated_cards = Enum.reject(socket.assigns.cards, fn c -> c.id == card_id end)

        {:noreply, assign(socket, :cards, updated_cards)}

      {:error, reason} ->
        {:noreply,
         socket
         |> put_flash(:error, "Failed to delete card: #{inspect(reason)}")}
    end
  end

  def handle_event("remove_member", %{"member_id" => member_id}, socket) do
    case Boards.remove_user_from_board(member_id) do
      {:ok, _} ->
        updated_members = Enum.reject(socket.assigns.members, fn m -> m.id == member_id end)

        {:noreply, assign(socket, :members, updated_members)}

      {:error, reason} ->
        {:noreply,
         socket
         |> put_flash(:error, "Failed to remove member: #{inspect(reason)}")}
    end
  end

  # Private helper function for setting page titles
  defp page_title(:show), do: "Show Board"
  defp page_title(:edit), do: "Edit Board"
  defp page_title(:new_list), do: "New List"
  defp page_title(:new_card), do: "New Card"
  defp page_title(:edit_card), do: "Edit Card"
  defp page_title(:add_members), do: "Add Members"
  defp page_title(:members), do: "All Members"
end
