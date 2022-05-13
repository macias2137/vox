defmodule Vox.Votes.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    belongs_to :restaurant, Vox.Restaurants.Restaurant
    belongs_to :user, Vox.UserManager.User

    timestamps()
  end

  @doc false
  def changeset(vote, attrs \\ %{}) do
    vote
    |> cast(attrs, [:user_id, :restaurant_id])
    |> validate_required([:user_id, :restaurant_id])
  end
end
