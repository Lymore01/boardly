defmodule Boardly.Repo.Migrations.AddCompletedToCards do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :completed, :boolean, default: false
    end
  end
end