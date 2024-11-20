defmodule Boardly.CardsTest do
  use Boardly.DataCase

  alias Boardly.Cards

  describe "cards" do
    alias Boardly.Cards.Card

    import Boardly.CardsFixtures

    @invalid_attrs %{position: nil, description: nil, title: nil, due_date: nil}

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Cards.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Cards.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      valid_attrs = %{position: 42, description: "some description", title: "some title", due_date: ~N[2024-11-15 11:00:00]}

      assert {:ok, %Card{} = card} = Cards.create_card(valid_attrs)
      assert card.position == 42
      assert card.description == "some description"
      assert card.title == "some title"
      assert card.due_date == ~N[2024-11-15 11:00:00]
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cards.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      update_attrs = %{position: 43, description: "some updated description", title: "some updated title", due_date: ~N[2024-11-16 11:00:00]}

      assert {:ok, %Card{} = card} = Cards.update_card(card, update_attrs)
      assert card.position == 43
      assert card.description == "some updated description"
      assert card.title == "some updated title"
      assert card.due_date == ~N[2024-11-16 11:00:00]
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Cards.update_card(card, @invalid_attrs)
      assert card == Cards.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Cards.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Cards.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Cards.change_card(card)
    end
  end

  describe "cards" do
    alias Boardly.Cards.Card

    import Boardly.CardsFixtures

    @invalid_attrs %{position: nil, description: nil, title: nil, due_date: nil}

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Cards.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Cards.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      valid_attrs = %{position: 42, description: "some description", title: "some title", due_date: ~N[2024-11-15 11:05:00]}

      assert {:ok, %Card{} = card} = Cards.create_card(valid_attrs)
      assert card.position == 42
      assert card.description == "some description"
      assert card.title == "some title"
      assert card.due_date == ~N[2024-11-15 11:05:00]
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cards.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      update_attrs = %{position: 43, description: "some updated description", title: "some updated title", due_date: ~N[2024-11-16 11:05:00]}

      assert {:ok, %Card{} = card} = Cards.update_card(card, update_attrs)
      assert card.position == 43
      assert card.description == "some updated description"
      assert card.title == "some updated title"
      assert card.due_date == ~N[2024-11-16 11:05:00]
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Cards.update_card(card, @invalid_attrs)
      assert card == Cards.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Cards.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Cards.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Cards.change_card(card)
    end
  end

  describe "cards" do
    alias Boardly.Cards.Card

    import Boardly.CardsFixtures

    @invalid_attrs %{position: nil, description: nil, title: nil, due_date: nil}

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Cards.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Cards.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      valid_attrs = %{position: 42, description: "some description", title: "some title", due_date: ~N[2024-11-15 12:33:00]}

      assert {:ok, %Card{} = card} = Cards.create_card(valid_attrs)
      assert card.position == 42
      assert card.description == "some description"
      assert card.title == "some title"
      assert card.due_date == ~N[2024-11-15 12:33:00]
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cards.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      update_attrs = %{position: 43, description: "some updated description", title: "some updated title", due_date: ~N[2024-11-16 12:33:00]}

      assert {:ok, %Card{} = card} = Cards.update_card(card, update_attrs)
      assert card.position == 43
      assert card.description == "some updated description"
      assert card.title == "some updated title"
      assert card.due_date == ~N[2024-11-16 12:33:00]
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Cards.update_card(card, @invalid_attrs)
      assert card == Cards.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Cards.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Cards.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Cards.change_card(card)
    end
  end
end
