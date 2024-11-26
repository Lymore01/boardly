defmodule Boardly.Cards.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :title, :string
    field :description, :string
    field :due_date, :utc_datetime
    field :completed, :boolean, default: false
    belongs_to :list, Boardly.Lists.List

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:title, :description, :due_date, :completed, :list_id])
    |> validate_required([:title, :list_id])
  end
end
