defmodule Vox.Votes do
  alias Vox.Votes.Vote
  alias Vox.Repo
  import Ecto.Query, only: [from: 2]

  def list_votes do
    Repo.all(Vote)
  end

  def get_vote!(id), do: raise "TODO"

  def get_vote_count_by_restaurant_id(restaurant_id) do
    votes = Repo.all(Vote, restaurant_id: restaurant_id)
    Enum.count(votes)
  end

  def get_vote_count_for_each_restaurant do
    query = from v in Vote,
    group_by: [v.restaurant_id],
    select: {v.restaurant_id, count(v.id)}
    votes_by_restaurant = Repo.all(query)
    for {id, count} <- votes_by_restaurant do
      %{restaurant_id: id, vote_count: count}
    end
  end

  def create_vote(attrs \\ %{}) do
    %Vote{}
    |> Vote.changeset(attrs)
    |> Repo.insert()
  end

  def update_vote(%Vote{} = vote, attrs) do
    raise "TODO"
  end

  def delete_vote(%Vote{} = vote) do
    raise "TODO"
  end

  def delete_all_votes do
    Repo.delete_all(Vote)
  end

  def change_vote(%Vote{} = vote, _attrs \\ %{}) do
    raise "TODO"
  end
end
