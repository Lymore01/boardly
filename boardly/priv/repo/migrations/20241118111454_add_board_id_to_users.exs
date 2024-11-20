defmodule Boardly.Repo.Migrations.AddBoardIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :board_id, references(:boards, on_delete: :nothing)
    end
  end
end
