defmodule Boardly.Cards.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :title, :string
    field :description, :string
    field :due_date, :utc_datetime
    belongs_to :list, Boardly.Lists.List
    belongs_to :assigned_user, Boardly.Accounts.User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:title, :description, :due_date, :list_id])
    |> validate_required([:title, :list_id])
  end

  def assignment_changeset(card, attrs) do
    card
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
    |> foreign_key_constraint(:user_id)
  end
end
