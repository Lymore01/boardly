defmodule Boardly.Repo.Migrations.SimplifyBoardUserRelationship do
  use Ecto.Migration

  def up do
    # Drop the users_boards table if it exists
    drop_if_exists table("users_boards")
    
    # Drop the memberships table if it exists
    drop_if_exists table("memberships")

    # Remove board_id from users if it exists
    alter table(:users) do
      remove_if_exists :board_id, :bigint
    end

    # Make sure boards.user_id is properly constrained
    execute "ALTER TABLE boards DROP CONSTRAINT IF EXISTS boards_user_id_fkey"
    alter table(:boards) do
      modify :user_id, references(:users, on_delete: :delete_all)
    end
  end

  def down do
    # If needed, revert to original state
    alter table(:boards) do
      modify :user_id, references(:users, on_delete: :nothing)
    end
  end
end