defmodule UnpackTest do
  use ExUnit.Case
  doctest Unpack

  setup do
    p1 = %{game: %{}}
    p2 = %{game: %{developer: %Ecto.Association.NotLoaded{}}}
    p3 = %{game: %{developer: %{id: "dev-id"}}}

    %{player1: p1, player2: p2, player3: p3}
  end

  describe "unpack/2" do
    test "returns nil if value not found from bad keys", %{player1: player} do
      assert Unpack.get_in(player, [:bogus_key]) == nil
      assert Unpack.get_in(player, [:game, :some_key]) == nil
      assert Unpack.get_in(player, [:game, :some_key, :another_key]) == nil
    end

    test "returns nil if key or value not found in nested attrs", %{player2: player} do
      assert Unpack.get_in(player, [:game, :developer]) == nil
      assert Unpack.get_in(player, [:game, :developer, :some_key]) == nil
      assert Unpack.get_in(player, [:game, :developer, :key, :k2]) == nil
    end

    test "returns value if key found in nested attrs", %{player3: player} do
      assert Unpack.get_in(player, [:game, :developer]) == %{id: "dev-id"}
      assert Unpack.get_in(player, [:game, :developer, :id]) == "dev-id"
    end
  end
end
