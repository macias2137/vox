defmodule VoxWeb.RestaurantsController do

  use VoxWeb, :controller

  alias Vox.Restaurants
  alias Vox.Restaurants.Restaurant
  alias Vox.Votes
  alias Vox.Votes.Vote

  def index(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    restaurants = Restaurants.list_restaurants()
    votes = Votes.get_vote_count_for_each_restaurant()
    changeset = Restaurant.changeset(%Restaurant{}, %{})
    render(conn, "index.html", current_user: current_user, restaurants: restaurants, changeset: changeset, votes: votes)
  end

  def update(conn, %{"id" => id}) do
    current_user = Guardian.Plug.current_resource(conn)
    restaurant = Restaurants.get_restaurant_by_id(id)
    # Restaurants.add_vote_to_restaurant(restaurant)
    Votes.create_vote(%{user_id: current_user.id, restaurant_id: restaurant.id})
    redirect(conn, to: Routes.restaurants_path(conn, :index))
  end

  def reset(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    if current_user.role == "admin" do
    # Restaurants.reset_all_votes()
    Votes.delete_all_votes()
    end
    redirect(conn, to: Routes.restaurants_path(conn, :index))
  end

  def new(conn, %{"name" => name}) do
    current_user = Guardian.Plug.current_resource(conn)
    if current_user.role == "admin" do
    Restaurants.add_new_restaurant(%{name: name})
    end
    redirect(conn, to: Routes.restaurants_path(conn, :index))
  end
end
