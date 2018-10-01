defmodule Unpack do
  @moduledoc """
  Unpack lets you "unpack" values from a nested map safely.

  It's a very lightweight module that expects you to have
  an Ecto dependency.
  """
  @doc """
  Traverses any nested map or `struct`, in order of `keys` list, to return a
  value. Returns nil for bad keys, unloaded ecto associations, or empty maps.

  ## Examples
      iex> struct = %{player: %{game: %{id: "game-id"}}}
      iex> Unpack.get(struct, [:player, :game, :id])
      "game-id"

      iex> struct = %{player: %Ecto.Association.NotLoaded{}}
      iex> Unpack.get(struct, [:player, :game, :id])
      nil
  """
  def get(%Ecto.Association.NotLoaded{}, _), do: nil
  def get(data, []), do: data
  def get(data, [key | tail]) when is_map(data), do:
    get(Map.get(data, key), tail)
  def get(_data, _keys), do: nil
end
