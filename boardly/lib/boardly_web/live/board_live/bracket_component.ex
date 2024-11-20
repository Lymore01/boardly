defmodule BoardlyWeb.BoardLive.BracketComponent do
  use BoardlyWeb, :live_component
  # use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div class="bg-gradient-to-r from-blue-500 via-indigo-600 to-purple-600 rounded-lg p-6 text-white shadow-lg flex flex-row justify-between">
      <div class="flex flex-col gap-3">
        <h1 class="text-lg font-semibold capitalize"><%= @bracket.name %></h1>
        <p class="text-xs"><%= @bracket.description %></p>
      </div>

      <!-- Actions for Edit and Delete -->
      <div class="mt-4 flex gap-4">
        <!-- Edit Action -->
        <.link
          patch={~p"/boards/#{@bracket.id}/edit"}
          class="bg-yellow-500 text-white py-2 px-4 rounded-md shadow-md hover:bg-yellow-600 transition"
        >
          Edit
        </.link>

        <!-- Delete Action -->
        <.link
          phx-click={JS.push("delete", value: %{id: @bracket.id}) |> hide("#board-#{@bracket.id}")}
          data-confirm="Are you sure?"
          class="bg-red-500 text-white py-2 px-4 rounded-md shadow-md hover:bg-red-600 transition"
        >
          Delete
        </.link>
      </div>
    </div>
    """
  end
end
