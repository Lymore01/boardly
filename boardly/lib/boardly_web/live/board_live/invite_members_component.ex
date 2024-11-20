defmodule BoardlyWeb.BoardLive.InviteMembersComponent do
  use BoardlyWeb, :live_component

  alias Boardly.Accounts
  alias Boardly.Boards

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage board records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="board-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:email]} type="email" label="Email" />
        <:actions>
          <.button phx-disable-with="Saving...">Add Member</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user: user} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Accounts.change_user_email(user))
     end)}
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_email(socket.assigns.user, user_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"user" => %{"email" => email}}, socket) do
    board_id = socket.assigns.board

    case Boards.invite_user_to_board(email, board_id) do
      {:ok, _user_board} ->
        {:noreply,
         socket
         |> put_flash(:info, "#{email} was successfully invited to the board.")
         |> push_patch(to: socket.assigns.patch)}

      {:error, reason} ->
        {:noreply,
         socket
         |> put_flash(:error, reason)
         |> push_patch(to: socket.assigns.patch)
        }
    end
  end


end
