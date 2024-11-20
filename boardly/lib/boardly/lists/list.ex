defmodule Boardly.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset
  alias Boardly.Cards.Card

  schema "lists" do
    field :name, :string
    field :position, :integer
    # field :board_id, :id
    belongs_to :board, Boardly.Boards.Board
    has_many :cards, Card

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(list, attrs) do
    list
  |> cast(attrs, [:name, :position, :board_id])
  |> validate_required([:name, :position, :board_id])
  end
end
