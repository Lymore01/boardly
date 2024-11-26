defmodule Boardly.Repo.Migrations.RemoveBoardIdFromUsers do
  use Ecto.Migration

  def up do
    # Check if column exists before trying to remove it
    execute """
    DO $$
    BEGIN
      IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'users'
        AND column_name = 'board_id'
      ) THEN
        ALTER TABLE users DROP CONSTRAINT IF EXISTS users_board_id_fkey;
        ALTER TABLE users DROP COLUMN board_id;
      END IF;
    END
    $$;
    """
  end

  def down do
    # No need to add it back since we're moving to boards having user_id
    :ok
  end
end