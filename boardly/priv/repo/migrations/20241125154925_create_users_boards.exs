defmodule Boardly.Repo.Migrations.CreateUsersBoards do
  use Ecto.Migration

  def change do
    create table(:users_boards) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :board_id, references(:boards, on_delete: :delete_all), null: false

      timestamps()
    end

    # Add unique index to prevent duplicate memberships
    create unique_index(:users_boards, [:user_id, :board_id])
  end
end
