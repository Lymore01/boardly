defmodule Boardly.Repo.Migrations.CleanupBoardUserRelationships do
   use Ecto.Migration

  def change do
    alter table(:users) do
      remove :board_id
    end

   
    drop_if_exists constraint("boards", "boards_user_id_fkey")
    alter table(:boards) do
      modify :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
