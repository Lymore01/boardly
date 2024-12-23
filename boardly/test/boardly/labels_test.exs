defmodule Boardly.LabelsTest do
  use Boardly.DataCase

  alias Boardly.Labels

  describe "labels" do
    alias Boardly.Labels.Label

    import Boardly.LabelsFixtures

    @invalid_attrs %{name: nil, color: nil}

    test "list_labels/0 returns all labels" do
      label = label_fixture()
      assert Labels.list_labels() == [label]
    end

    test "get_label!/1 returns the label with given id" do
      label = label_fixture()
      assert Labels.get_label!(label.id) == label
    end

    test "create_label/1 with valid data creates a label" do
      valid_attrs = %{name: "some name", color: "some color"}

      assert {:ok, %Label{} = label} = Labels.create_label(valid_attrs)
      assert label.name == "some name"
      assert label.color == "some color"
    end

    test "create_label/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Labels.create_label(@invalid_attrs)
    end

    test "update_label/2 with valid data updates the label" do
      label = label_fixture()
      update_attrs = %{name: "some updated name", color: "some updated color"}

      assert {:ok, %Label{} = label} = Labels.update_label(label, update_attrs)
      assert label.name == "some updated name"
      assert label.color == "some updated color"
    end

    test "update_label/2 with invalid data returns error changeset" do
      label = label_fixture()
      assert {:error, %Ecto.Changeset{}} = Labels.update_label(label, @invalid_attrs)
      assert label == Labels.get_label!(label.id)
    end

    test "delete_label/1 deletes the label" do
      label = label_fixture()
      assert {:ok, %Label{}} = Labels.delete_label(label)
      assert_raise Ecto.NoResultsError, fn -> Labels.get_label!(label.id) end
    end

    test "change_label/1 returns a label changeset" do
      label = label_fixture()
      assert %Ecto.Changeset{} = Labels.change_label(label)
    end
  end
end
