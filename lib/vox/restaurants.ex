defmodule Vox.Restaurants do
  #this is a context module
  alias Vox.Restaurants.Restaurant
  alias Vox.Repo
  import Ecto.Changeset
  import Ecto.Query

  def get_restaurant_by_id(id) do
    Repo.get(Restaurant, id)
  end

  def list_restaurants() do
    query = Restaurant |> order_by(desc: :id)
    Repo.all(query)
  end

  def add_vote_to_restaurant(restaurant) when is_struct(restaurant) do
    restaurant = change(restaurant, vote_count: restaurant.vote_count + 1)
    Repo.update(restaurant)
  end

  def reset_all_votes do
    Repo.update_all(Restaurant, set: [vote_count: 0])
  end

  def create_restaurant(params \\ %{}) do
  %Restaurant{}
  |> Restaurant.changeset(params)
  |> Repo.insert
  end
end
