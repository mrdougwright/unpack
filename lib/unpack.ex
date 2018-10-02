defmodule Unpack do
  @moduledoc """
  Unpack lets you "unpack" values from a nested map safely.
  """
  @doc """
  Traverses any nested map or `struct`, in order of `keys` list, to return a
  value. Returns nil for bad keys or empty maps.

  ## Examples
      iex> struct = %{player: %{game: %{id: "game-id"}}}
      iex> Unpack.get(struct, [:player, :game, :id])
      "game-id"

      iex> struct = %{player: %{}}
      iex> Unpack.get(struct, [:player, :game, :id])
      nil
  """
  if Code.ensure_loaded?(Ecto) do
    def get(%Ecto.Association.NotLoaded{}, _), do: nil
  end

  def get(data, [key | tail]) when is_map(data), do: get(Map.get(data, key), tail)

  def get(data, []) when is_map(data) do
    case map_size(data) do
      0 -> nil
      _ -> data
    end
  end

  def get(data, []), do: data
  def get(_data, _keys), do: nil
end
