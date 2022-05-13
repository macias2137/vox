defmodule Vox.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :user_id, references(:users)
      add :restaurant_id, references(:restaurants)

      timestamps()
    end

    create unique_index(:votes, [:user_id])

  end
end
