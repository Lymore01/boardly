defmodule Boardly.LabelsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Boardly.Labels` context.
  """

  @doc """
  Generate a label.
  """
  def label_fixture(attrs \\ %{}) do
    {:ok, label} =
      attrs
      |> Enum.into(%{
        color: "some color",
        name: "some name"
      })
      |> Boardly.Labels.create_label()

    label
  end
end
