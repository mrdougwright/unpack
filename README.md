# Unpack

This tiny Elixir drop let's you reach in and unpack any value from a nested map. Returns nil for bad keys, unloaded associations, or empty maps.

# Examples
```elixir
struct = %{player: %{game: %{id: "game-id"}}}
Unpack.get(struct, [:player, :game, :id])
=> "game-id"

struct = %{player: %{}}
Unpack.get(struct, [:player, :game, :id])
=> nil
```
Docs can be found at [https://hexdocs.pm/unpack](https://hexdocs.pm/unpack).

## Installation

Availabe as [Hex package](https://hex.pm/packages/unpack), the package can be installed by adding `unpack` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:unpack, "~> 0.1.1"}
  ]
end
```

## Testing
To test this package, run `mix test`. To submit a PR, please fork this repo first.
