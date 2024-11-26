defmodule BoardlyWeb.BoardLive.BracketComponent do
  use BoardlyWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="flex items-center justify-between bg-white p-4 rounded-lg shadow hover:shadow-md transition-all duration-200">
      <div>
        <h1 class="text-gray-900 font-medium"><%= @bracket.name %></h1>
        <p class="text-sm text-gray-500"><%= @bracket.description %></p>
      </div>

      <div class="flex items-center gap-3 ml-4">
        <.link 
          patch={~p"/boards/#{@bracket.id}/edit"}
          class="p-2 text-gray-400 hover:text-blue-600 hover:bg-blue-50 rounded-full transition-all duration-200"
        >
          <i class="fas fa-edit"></i>
        </.link>
        
        <button 
          phx-click="delete"
          phx-value-id={@bracket.id}
          data-confirm="Are you sure you want to delete this board?"
          class="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-full transition-all duration-200"
        >
          <i class="fas fa-trash"></i>
        </button>
      </div>
    </div>
    """
  end
end
