defmodule Boardly.Repo.Migrations.CreateLabels do
  use Ecto.Migration

  def change do
    create table(:labels) do
      add :name, :string
      add :color, :string
      add :board_id, references(:boards, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:labels, [:board_id])
  end
end
