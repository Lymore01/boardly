defmodule Boardly.MembershipsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Boardly.Memberships` context.
  """

  @doc """
  Generate a membership.
  """
  def membership_fixture(attrs \\ %{}) do
    {:ok, membership} =
      attrs
      |> Enum.into(%{
        role: "some role"
      })
      |> Boardly.Memberships.create_membership()

    membership
  end
end
