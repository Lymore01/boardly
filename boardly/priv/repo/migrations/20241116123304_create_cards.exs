defmodule Boardly.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :title, :string
      add :description, :text
      add :due_date, :naive_datetime
      add :position, :integer
      add :list_id, references(:lists, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:cards, [:list_id])
  end
end
