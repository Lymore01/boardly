defmodule Boardly.Cards.Card do
  use Ecto.Schema
  import Ecto.Changeset
  alias Boardly.Lists.List

  schema "cards" do
    field :position, :integer
    field :description, :string
    field :title, :string
    field :due_date, :naive_datetime
    # field :list_id, :id
    belongs_to :list, List

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:title, :description, :due_date, :position, :list_id])
    |> validate_required([:title, :description, :due_date, :position, :list_id])
  end
end
