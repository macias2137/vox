defmodule Vox.UserManagerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Vox.UserManager` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        password: "some password",
        password_hash: "some password_hash",
        role: "some role",
        username: "some username"
      })
      |> Vox.UserManager.create_user()

    user
  end
end
