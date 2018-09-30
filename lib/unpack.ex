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
    try do
      case Kernel.get_in(struct, keys) do
        %Ecto.Association.NotLoaded{} -> nil
        result -> result
      end
    rescue
      e in UndefinedFunctionError ->
        case e.module do
          Ecto.Association.NotLoaded -> nil
          _otherwise -> raise e
        end
    end
  end
end
