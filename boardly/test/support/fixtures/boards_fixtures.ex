defmodule Boardly.BoardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Boardly.Boards` context.
  """

  @doc """
  Generate a board.
  """
  def board_fixture(attrs \\ %{}) do
    {:ok, board} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Boardly.Boards.create_board()

    board
  end
end
