defmodule Boardly.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :name, :string
    belongs_to :board, Boardly.Boards.Board
    has_many :cards, Boardly.Cards.Card, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name, :board_id])
    |> validate_required([:name, :board_id])
  end
end
