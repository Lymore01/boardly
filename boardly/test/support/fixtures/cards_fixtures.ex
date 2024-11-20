defmodule Boardly.CardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Boardly.Cards` context.
  """

  @doc """
  Generate a card.
  """
  def card_fixture(attrs \\ %{}) do
    {:ok, card} =
      attrs
      |> Enum.into(%{
        description: "some description",
        due_date: ~N[2024-11-15 11:00:00],
        position: 42,
        title: "some title"
      })
      |> Boardly.Cards.create_card()

    card
  end

  @doc """
  Generate a card.
  """
  def card_fixture(attrs \\ %{}) do
    {:ok, card} =
      attrs
      |> Enum.into(%{
        description: "some description",
        due_date: ~N[2024-11-15 11:05:00],
        position: 42,
        title: "some title"
      })
      |> Boardly.Cards.create_card()

    card
  end

  @doc """
  Generate a card.
  """
  def card_fixture(attrs \\ %{}) do
    {:ok, card} =
      attrs
      |> Enum.into(%{
        description: "some description",
        due_date: ~N[2024-11-15 12:33:00],
        position: 42,
        title: "some title"
      })
      |> Boardly.Cards.create_card()

    card
  end
end
