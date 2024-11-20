defmodule Boardly.Memberships.Membership do
  use Ecto.Schema
  import Ecto.Changeset

  schema "memberships" do
    field :role, :string
    field :user_id, :id
    # field :board_id, :id
    belongs_to :board, Boardly.Boards.Board

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(membership, attrs) do
    membership
    |> cast(attrs, [:role, :board_id])
    |> validate_required([:role, :board_id])
  end
end
