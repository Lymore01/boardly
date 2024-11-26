defmodule Boardly.Boards.Board do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boards" do
    field :name, :string
    field :description, :string
    belongs_to :user, Boardly.Accounts.User
    has_many :lists, Boardly.Lists.List

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name, :description, :user_id])
    |> validate_required([:name, :user_id])
  end
end