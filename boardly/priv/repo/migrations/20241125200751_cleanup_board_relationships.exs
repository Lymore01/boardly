defmodule Boardly.Repo.Migrations.CleanupBoardRelationships do
 defmodule Boardly.Repo.Migrations.CleanupBoardRelationships do
  use Ecto.Migration

  def up do
    # First remove the circular reference from users to boards
    execute "ALTER TABLE users DROP CONSTRAINT IF EXISTS users_board_id_fkey"
    execute "ALTER TABLE users DROP COLUMN IF EXISTS board_id"

    # Drop the memberships table as we're using users_boards
    drop_if_exists table("memberships")

    # Make sure user_id in boards is properly constrained
    execute "ALTER TABLE boards DROP CONSTRAINT IF EXISTS boards_user_id_fkey"
    alter table(:boards) do
      modify :user_id, references(:users, on_delete: :delete_all)
    end

    # Ensure proper cascade delete for lists
    execute "ALTER TABLE lists DROP CONSTRAINT IF EXISTS lists_board_id_fkey"
    alter table(:lists) do
      modify :board_id, references(:boards, on_delete: :delete_all)
    end

    # Update labels constraint if it exists
    execute "ALTER TABLE labels DROP CONSTRAINT IF EXISTS labels_board_id_fkey"
    alter table(:labels) do
      modify :board_id, references(:boards, on_delete: :delete_all)
    end
  end

  def down do
    # Add back the original constraints if needed to rollback
    alter table(:lists) do
      modify :board_id, references(:boards, on_delete: :nothing)
    end

    alter table(:labels) do
      modify :board_id, references(:boards, on_delete: :nothing)
    end

    alter table(:boards) do
      modify :user_id, references(:users, on_delete: :nothing)
    end
  end
end
end
