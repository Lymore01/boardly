defmodule Boardly.Repo.Migrations.CreateAttachments do
  use Ecto.Migration

  def change do
    create table(:attachments) do
      add :file_url, :string
      add :card_id, references(:cards, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:attachments, [:card_id])
    create index(:attachments, [:user_id])
  end
end
