defmodule Vox.Votes do
  alias Vox.Votes.Vote
  alias Vox.Repo
  import Ecto.Query

  def list_votes do
    Repo.all(Vote)
  end

  def get_vote_count_by_restaurant_id(restaurant_id) do
    votes = Repo.all(Vote, restaurant_id: restaurant_id)
    Enum.count(votes)
  end

  def get_vote_count_for_restaurants do
    Vote
    |> group_by([v], v.restaurant_id)
    |> select([v], {v.restaurant_id, count(v.id)})
    |> Repo.all()
    |> Map.new()
  end

  def get_voter_ids do
    Repo.all(from v in Vote, select: v.user_id, order_by: [asc: v.user_id])
  end

  def create_vote(attrs \\ %{}) do
    %Vote{}
    |> Vote.changeset(attrs)
    |> Repo.insert()
  end

  def delete_all_votes do
    Repo.delete_all(Vote)
  end
end
