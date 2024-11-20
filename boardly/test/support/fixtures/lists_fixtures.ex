defmodule Boardly.ListsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Boardly.Lists` context.
  """

  @doc """
  Generate a list.
  """
  def list_fixture(attrs \\ %{}) do
    {:ok, list} =
      attrs
      |> Enum.into(%{
        name: "some name",
        position: 42
      })
      |> Boardly.Lists.create_list()

    list
  end
end
