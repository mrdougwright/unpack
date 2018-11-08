defmodule UnpackTest do
  use ExUnit.Case
  doctest Unpack

  defmodule Game do
    defstruct [:developer]
  end

  defmodule Developer do
    defstruct [:name]
  end

  setup do
    p1 = %{game: %{}}
    p2 = %{game: %{developer: %{}}}
    p3 = %{game: %{developer: %{id: "dev-id"}}}

    %{player1: p1, player2: p2, player3: p3}
  end

  describe "unpack/2" do
    test "returns nil if value not found from bad keys", %{player1: player} do
      assert Unpack.get(player, [:bogus_key]) == nil
      assert Unpack.get(player, [:game, :some_key]) == nil
      assert Unpack.get(player, [:game, :some_key, :another_key]) == nil
    end

    test "returns nil if key or value not found in nested attrs", %{player2: player} do
      assert Unpack.get(player, [:game, :developer]) == nil
      assert Unpack.get(player, [:game, :developer, :some_key]) == nil
      assert Unpack.get(player, [:game, :developer, :key, :k2]) == nil
    end

    test "returns value if key found in nested attrs", %{player3: player} do
      assert Unpack.get(player, [:game, :developer]) == %{id: "dev-id"}
      assert Unpack.get(player, [:game, :developer, :id]) == "dev-id"
    end

    test "returns nil if value not found in nested structs" do
      struct = %{game: %Game{developer: %Developer{}}}
      assert Unpack.get(struct, [:game, :developer, :name]) == nil
      assert Unpack.get(struct, [:game, :dev, :bad_key]) == nil
    end

    test "returns value if key found in nested structs" do
      struct = %{game: %Game{developer: %Developer{name: "Nascar"}}}
      assert Unpack.get(struct, [:game, :developer, :name]) == "Nascar"
    end

    if Code.ensure_loaded?(Ecto) do
      test "returns nil if value is an unloaded Ecto relation" do
        struct = %{game: %Game{developer: %Ecto.Association.NotLoaded{}}}
        assert Unpack.get(struct, [:game, :developer]) == nil
      end
    end
  end

  describe "unpack/3" do
    test "returns a default value of nil if 3rd param not passed" do
      struct = %{game: %Game{developer: %Developer{}}}
      assert Unpack.get(struct, [:game, :developer, :age]) == nil
    end

    test "returns default value if key value not found" do
      struct = %{game: %Game{developer: %Developer{}}}
      assert Unpack.get(struct, [:game, :developer, :age], "wut!?") == "wut!?"
    end
  end
end
