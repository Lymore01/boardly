defmodule Boardly.AttachmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Boardly.Attachments` context.
  """

  @doc """
  Generate a attachment.
  """
  def attachment_fixture(attrs \\ %{}) do
    {:ok, attachment} =
      attrs
      |> Enum.into(%{
        file_url: "some file_url"
      })
      |> Boardly.Attachments.create_attachment()

    attachment
  end
end
