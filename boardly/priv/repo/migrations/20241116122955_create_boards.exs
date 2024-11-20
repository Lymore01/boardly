defmodule Boardly.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :name, :string
      add :description, :text

      timestamps(type: :utc_datetime)
    end
  end
end
