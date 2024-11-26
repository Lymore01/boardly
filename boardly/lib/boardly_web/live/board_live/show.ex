defmodule BoardlyWeb.BoardLive.Show do
  use BoardlyWeb, :live_view

  alias Boardly.Boards
  alias Boardly.Lists
  alias Boardly.Lists.List
  alias Boardly.Cards
  alias Boardly.Cards.Card

  @impl true
  def mount(_params, session, socket) do
    user = Boardly.Accounts.get_user_by_session_token(session["user_token"])
    {:ok, assign(socket, :current_user, user)}
  end

  def handle_params(%{"id" => id, "list_id" => list_id, "card_id" => card_id}, _, socket) do
    board = Boards.get_board_with_lists(id, socket.assigns.current_user.id)
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
    board = Boards.get_board_with_lists(id, socket.assigns.current_user.id)
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
    case Boards.get_board_with_lists(id, socket.assigns.current_user.id) do
      nil ->
        {:noreply,
         socket
         |> put_flash(:error, "Board not found")
         |> push_navigate(to: ~p"/boards")}

      board ->
        {:noreply,
         socket
         |> assign(:page_title, page_title(socket.assigns.live_action))
         |> assign(:board, board)
         |> assign(:lists, board.lists)
         |> assign(:list, %List{})
         |> assign(:card, %Card{})
         |> assign(:cards, [])}
    end
  end

  @impl true
  def handle_info({BoardlyWeb.CardLive.FormComponent, {:saved, _card}}, socket) do
    board = Boards.get_board_with_lists(socket.assigns.board.id, socket.assigns.current_user.id)
    
    {:noreply,
     socket
     |> assign(:lists, board.lists)
     |> put_flash(:info, "Card saved successfully")}
  end

  @impl true
  def handle_info({BoardlyWeb.ListLive.FormComponent, {:saved, _list}}, socket) do
    board = Boards.get_board_with_lists(socket.assigns.board.id, socket.assigns.current_user.id)
    
    {:noreply,
     socket
     |> assign(:lists, board.lists)}
  end

  @impl true
  def handle_info({BoardlyWeb.BoardLive.FormComponent, {:saved, board}}, socket) do
    {:noreply,
     socket
     |> assign(:board, board)
     |> put_flash(:info, "Board updated successfully")}
  end

  @impl true
  def handle_event("delete_list", %{"id" => list_id}, socket) do
    list = Lists.get_list!(list_id)

    case Lists.delete_list(list) do
      {:ok, _list} ->
        board = Boards.get_board_with_lists(socket.assigns.board.id, socket.assigns.current_user.id)

        {:noreply,
         socket
         |> assign(:lists, board.lists)
         |> put_flash(:info, "List deleted successfully")}

      {:error, _changeset} ->
        {:noreply,
         socket
         |> put_flash(:error, "Could not delete list")}
    end
  end

  @impl true
  def handle_event("delete_card", %{"id" => card_id}, socket) do
    card = Cards.get_card!(card_id)

    case Cards.delete_card(card) do
      {:ok, _card} ->
        board = Boards.get_board_with_lists(socket.assigns.board.id, socket.assigns.current_user.id)

        {:noreply,
         socket
         |> assign(:lists, board.lists)
         |> put_flash(:info, "Card deleted successfully")}

      {:error, _changeset} ->
        {:noreply,
         socket
         |> put_flash(:error, "Could not delete card")}
    end
  end

  @impl true
  def handle_event("toggle_complete", %{"id" => card_id}, socket) do
    card = Cards.get_card!(card_id)
    
    case Cards.toggle_complete(card) do
      {:ok, _card} ->
        board = Boards.get_board_with_lists(socket.assigns.board.id, socket.assigns.current_user.id)

        {:noreply,
         socket
         |> assign(:lists, board.lists)
         |> put_flash(:info, "Card updated successfully")}

      {:error, _changeset} ->
        {:noreply,
         socket
         |> put_flash(:error, "Could not update card")}
    end
  end

  # Private helper function for setting page titles
  defp page_title(:show), do: "Show Board"
  defp page_title(:edit), do: "Edit Board"
  defp page_title(:new_list), do: "New List"
  defp page_title(:new_card), do: "New Card"
  defp page_title(:edit_card), do: "Edit Card"
  defp page_title(:edit_list), do: "Edit List"
end
