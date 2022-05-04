defmodule VoxWeb.RestaurantsController do
  use VoxWeb, :controller

  alias Vox.Restaurants
  alias Vox.Restaurants.Restaurant

  def index(conn, _params) do
    restaurants = Restaurants.list_restaurants()
    changeset = Restaurant.changeset(%Restaurant{}, %{})
    render(conn, "index.html", restaurants: restaurants, changeset: changeset)
  end

  def update(conn, %{"id" => id}) do
    restaurant = Restaurants.get_restaurant_by_id(id)
    Restaurants.add_vote_to_restaurant(restaurant)
    redirect(conn, to: Routes.restaurants_path(conn, :index))
  end

  def reset(conn, _params) do
    Restaurants.reset_all_votes()
    redirect(conn, to: Routes.restaurants_path(conn, :index))
  end

  def new(conn, %{"name" => name}) do
    Restaurants.add_new_restaurant(%{name: name})
    redirect(conn, to: Routes.restaurants_path(conn, :index))
  end
end