defmodule Boardly.Repo.Migrations.FixBoardUserConstraints do
  use Ecto.Migration

  def up do
    
    execute "ALTER TABLE boards DROP CONSTRAINT IF EXISTS boards_user_id_fkey"
    
    execute "ALTER TABLE boards DROP COLUMN IF EXISTS user_id"
    
   
    alter table(:boards) do
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end

  def down do
    
    execute "ALTER TABLE boards DROP CONSTRAINT IF EXISTS boards_user_id_fkey"
    execute "ALTER TABLE boards DROP COLUMN IF EXISTS user_id"
  end
end
