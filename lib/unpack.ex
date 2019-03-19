defmodule Unpack do
  @moduledoc """
  Unpack lets you safely "unpack" any values from a nested map, struct or database object.
  """

  @doc """
  Traverses nested `data` map or struct in order of keys `list` to return a value.
  Returns nil for missing keys, unloaded associations or empty maps.

  ## Examples
      iex> map = %{player: %{game: %{id: "game_id"}}}
      iex> Unpack.get(map, [:player, :game, :id])
      "game_id"

      iex> struct = %{player: %Ecto.Association.NotLoaded{}}
      iex> Unpack.get(struct, [:player, :game, :id])
      nil
  """
  @spec get(map(), [any()]) :: any() | nil
  def get(data, list), do: get(data, list, nil)

  @doc """
  Traverses nested `data` map or struct in order of keys `list` to return a value.
  Returns given `default` parameter for missing keys, unloaded associations or empty maps.

  ## Examples
      iex> map = %{player: %{name: "George"}}
      iex> Unpack.get(map, [:player, :email], "🙈")
      "🙈"
  """
  @spec get(map(), [any()], any()) :: any()
  def get(data, list, default)

  def get(%{__struct__: Ecto.Association.NotLoaded}, _keys, default), do: default

  def get(data, [key | tail], default) when is_map(data) do
    get(Map.get(data, key), tail, default)
  end

  def get(data, [], default) when is_map(data) do
    case map_size(data) do
      0 -> default
      _ -> data
    end
  end

  def get(false, [], _default), do: false
  def get(data, [], default), do: data || default
  def get(_data, _keys, default), do: default
end
