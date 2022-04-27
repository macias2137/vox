defmodule VoxWeb.RestaurantsController do
  use VoxWeb, :controller

  alias Vox.Restaurants

  def index(conn, _params) do
    restaurants = Restaurants.list_restaurants()
    render(conn, "index.html", restaurants: restaurants)
  end
end
