defmodule BoardlyWeb.BoardLive.ViewMembersComponent do
  use BoardlyWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>View all members in your board.</:subtitle>
      </.header>

      <%= if Enum.empty?(@members) do %>
        <p class="text-sm mt-4 text-[grey]">No members are currently invited</p>
      <%end%>

      <.table id="members" rows={@members}>
        <:col :let={member} >

          <%= member.email %>
        </:col>

        <:col :let={member}>
          <.button phx-click={
            JS.push("remove_member", value: %{member_id: member.id}) |> hide("#member-#{member.id}")
          }>
            Remove
          </.button>
        </:col>
      </.table>
    </div>
    """
  end
end
