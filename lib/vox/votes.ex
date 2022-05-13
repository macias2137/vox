defmodule Vox.Votes do
  alias Vox.Votes.Vote
  alias Vox.Repo
  import Ecto.Query

  def list_votes do
    Repo.all(Vote)
  end

  def user_voted?(id) do
   Vote
   |> where([v], v.user_id == ^id)
   |> Repo.exists?()
  end

  def get_vote_count_for_restaurants do
    Vote
    |> group_by([v], v.restaurant_id)
    |> select([v], {v.restaurant_id, count(v.id)})
    |> Repo.all()
    |> Map.new()
  end

  def create_vote(attrs = %{user_id: user_id} \\ %{}) do
    unless user_voted?(user_id) do
    %Vote{}
    |> Vote.changeset(attrs)
    |> Repo.insert()
    end
  end

  def delete_all_votes do
    Repo.delete_all(Vote)
  end
end
