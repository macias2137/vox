defmodule VoxWeb.RestaurantsController do

  use VoxWeb, :controller

  alias Vox.Restaurants
  alias Vox.Restaurants.Restaurant
  alias Vox.Votes
  alias Vox.Votes.Vote

  def index(conn, _params) do
    restaurants = Restaurants.list_restaurants()
    votes_by_restaurant = Votes.get_vote_count_for_each_restaurant()
    changeset = Restaurant.changeset(%Restaurant{}, %{})
    render(conn, "index.html", restaurants: restaurants, changeset: changeset, votes_by_restaurant: votes_by_restaurant)
  end

  def update(conn, %{"id" => id}) do
    restaurant = Restaurants.get_restaurant_by_id(id)
    Votes.create_vote(%{user_id: conn.assigns.current_user.id, restaurant_id: restaurant.id})
    redirect(conn, to: Routes.restaurants_path(conn, :index))
  end

  def reset(conn, _params) do
    if conn.assigns.current_user.role == "admin" do
    Votes.delete_all_votes()
    end
    redirect(conn, to: Routes.restaurants_path(conn, :index))
  end

  def new(conn, %{"name" => name}) do
    if conn.assigns.current_user.role == "admin" do
    Restaurants.add_new_restaurant(%{name: name})
    end
    redirect(conn, to: Routes.restaurants_path(conn, :index))
  end
end
