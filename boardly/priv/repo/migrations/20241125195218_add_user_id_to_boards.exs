defmodule Boardly.Repo.Migrations.AddUserIdToBoards do
  use Ecto.Migration

  def change do
    alter table(:boards) do
      add :user_id, references(:users, on_delete: :delete_all), null: true
    end

    create index(:boards, [:user_id])

    # After adding all user associations, you can make it non-nullable
    # You'll need to run a separate migration after associating users with boards
  end
end