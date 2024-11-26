defmodule Boardly.Repo.Migrations.UpdateCardsListForeignKey do
  use Ecto.Migration

  def change do
    drop constraint(:cards, "cards_list_id_fkey")
    alter table(:cards) do
      modify :list_id, references(:lists, on_delete: :delete_all)
    end
  end
end