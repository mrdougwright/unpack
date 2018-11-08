defmodule Unpack do
  @moduledoc """
  Unpack lets you "unpack" values from a nested map safely.
  """
  @doc """
  Traverses any nested `map` or `struct` (data), in order of keys list (arg2),
  to return a value. Returns `nil` for bad keys, unloaded associations or empty maps.
  Can also take a 3rd param to change default return value.

  ## Examples
      iex> map = %{player: %{game: %{id: "game-id"}}}
      iex> Unpack.get(map, [:player, :game, :id])
      "game-id"

      iex> struct = %{player: %Ecto.Association.NotLoaded{}}
      iex> Unpack.get(struct, [:player, :game, :id])
      nil

      iex> map = %{player: %{}}
      iex> Unpack.get(map, [:player, :wrong_key], "eh!")
      "eh!"
  """
  def get(data, list, default \\ nil)

  if Code.ensure_loaded?(Ecto) do
    def get(%Ecto.Association.NotLoaded{}, _, default), do: default
  end

  @spec get(map(), [any()]) :: any() | nil
  def get(data, [key | tail], default) when is_map(data), do:
    get(Map.get(data, key), tail, default)

  def get(data, [], default) when is_map(data) do
    case map_size(data) do
      0 -> default
      _ -> data
    end
  end

  def get(data, [], default), do: data || default
  def get(_data, _keys, default), do: default
end
