defmodule Vox.Restaurants.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "restaurants" do
    field :name, :string
    field :vote_count, :integer

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :vote_count])
    |> validate_required([:name, :vote_count])
    |> validate_number(:vote_count, greater_than_or_equal_to: 0)
    |> unique_constraint(:name)
  end
end
