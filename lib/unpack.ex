defmodule Unpack do
  @moduledoc """
  Unpack lets you "unpack" values from a nested map safely.
  """

  @doc """
  Traverses any nested map or `struct`, in order of `keys` list, to return a
  value. Returns nil for bad keys, unloaded associations, or empty maps.

  ## Examples
      iex> struct = %{player: %{game: %{id: "game-id"}}}
      iex> Unpack.get_in(struct, [:player, :game, :id])
      "game-id"

      iex> struct = %{player: %Ecto.Association.NotLoaded{}}
      iex> Unpack.get_in(struct, [:player, :game, :id])
      nil
  """
  def get_in(struct, keys) do
    keys
    |> Enum.reduce(struct, &extract_value(&1, &2))
    |> handle_result()
  end

  defp extract_value(key, map) do
    case Map.get(map, key) do
      %Ecto.Association.NotLoaded{} -> %{}
      nil -> %{}
      val -> val
    end
  end

  defp handle_result(map) when is_map(map) do
    case map_size(map) do
      0 -> nil
      _ -> map
    end
  end

  defp handle_result(value), do: value
end
