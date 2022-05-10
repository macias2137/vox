defmodule Vox.VotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Vox.Votes` context.
  """

  @doc """
  Generate a vote.
  """
  def vote_fixture(attrs \\ %{}) do
    {:ok, vote} =
      attrs
      |> Enum.into(%{

      })
      |> Vox.Votes.create_vote()

    vote
  end
end
