defmodule VoxWeb.RestaurantsController do

  use VoxWeb, :controller

  alias Vox.Restaurants
  alias Vox.Restaurants.Restaurant
  alias Vox.Votes

  def index(conn, _params) do
    restaurants = Restaurants.list_restaurants()
    votes_by_restaurant = Votes.get_vote_count_for_restaurants()
    changeset = Restaurant.changeset(%Restaurant{}, %{})
    render(conn, "index.html", restaurants: restaurants, changeset: changeset, votes_by_restaurant: votes_by_restaurant)
  end

  def update(conn, %{"id" => id}) do
    restaurant = Restaurants.get_restaurant_by_id(id)
    voter_ids = Votes.get_voter_ids()
    if conn.assigns.current_user.id not in voter_ids do
      Votes.create_vote(%{user_id: conn.assigns.current_user.id, restaurant_id: restaurant.id})
    end
    conn
    |> put_flash(:info, "You have already voted !")
    |> redirect(to: Routes.restaurants_path(conn, :index))

  end

  def reset(conn, _params) do
    if conn.assigns.current_user.role == "admin" do
      Votes.delete_all_votes()
    end
    conn
    |> put_flash(:info, "Vote pool reset")
    |> redirect(to: Routes.restaurants_path(conn, :index))
  end

  def new(conn, %{"name" => name}) do
    if conn.assigns.current_user.role == "admin" do
      Restaurants.create_restaurant(%{name: name})
    end
    redirect(conn, to: Routes.restaurants_path(conn, :index))
  end
end
