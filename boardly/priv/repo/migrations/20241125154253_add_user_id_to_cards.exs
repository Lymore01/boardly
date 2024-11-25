defmodule Boardly.Repo.Migrations.AddUserIdToCards do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :user_id, references(:users, on_delete: :nilify_all)
    end

    create index(:cards, [:user_id])
  end
end
