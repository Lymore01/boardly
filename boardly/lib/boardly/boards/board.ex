defmodule Boardly.Boards.Board do
  use Ecto.Schema
  import Ecto.Changeset
  alias Boardly.Lists.List

  schema "boards" do
    field :name, :string
    field :description, :string
    has_many :lists, List
    has_many :users, Boardly.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
