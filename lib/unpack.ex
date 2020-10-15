defmodule Unpack do
  @moduledoc """
  Unpack has two functions.
  `get` lets you safely "unpack" any values from a nested map, struct or database object.
  `from_struct` will convert a struct (and nested structs) to a map.
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

  @doc """
  Deep convert a struct to a map, including nested struct values or nested lists.

  ## Examples
      defmodule Game do
        defstruct [:name]
      end

      defmodule Developer do
        defstruct [:games]
      end

      struct = %Developer{games: [%Game{name: "RDR2"}]}

      Unpack.from_struct(struct)
      => %{games: [%{name: "RDR2"}]}
  """
  def from_struct(struct) when is_map(struct) do
    case Map.has_key?(struct, :__struct__) do
      true ->
        struct
        |> Map.from_struct()
        |> Enum.into(%{}, fn {k, v} -> {k, from_struct(v)} end)

      false ->
        struct
        |> Enum.into(%{}, fn {k, v} -> {k, from_struct(v)} end)
    end
  end

  def from_struct(list) when is_list(list) do
    Enum.map(list, &from_struct/1)
  end

  def from_struct(value), do: value
end
