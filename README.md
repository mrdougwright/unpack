# Unpack

This tiny Elixir drop let's you reach in and unpack any value from a nested map. Returns nil for bad keys, unloaded associations, or empty maps.

# Examples
```elixir
struct = %{player: %{game: %{id: "game-id"}}}
Unpack.get(struct, [:player, :game, :id])
=> "game-id"

struct = %{player: %Ecto.Association.NotLoaded{}}
Unpack.get(struct, [:player, :game, :id])
=> nil
```

# Dependencies
This Elixir drop uses `Ecto` as a dev dependency. If you're not using Ecto you may have issues with this little library. Let me know or submit a PR!

## Installation

Availabe as [Hex package](https://hex.pm/packages/unpack), the package can be installed by adding `unpack` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:unpack, "~> 0.1.0"}
  ]
end
```

Once published, the docs can be found at [https://hexdocs.pm/unpack](https://hexdocs.pm/unpack).
