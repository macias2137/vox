defmodule Vox.Votes do
  alias Vox.Votes.Vote
  alias Vox.Repo

  def list_votes do
    Repo.all(Vote)
  end

  def get_vote!(id), do: raise "TODO"

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

  def change_vote(%Vote{} = vote, _attrs \\ %{}) do
    raise "TODO"
  end
end
