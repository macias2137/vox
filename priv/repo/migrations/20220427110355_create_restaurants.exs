defmodule Vox.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants) do
      add :name, :string
      add :vote_count, :integer, default: 1

      timestamps()
    end

    create unique_index(:restaurants, [:name])
  end
end
