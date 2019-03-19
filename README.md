# Unpack

This tiny Elixir drop lets you reach in and unpack any value from a nested map. Returns nil for bad or missing keys, unloaded associations, or empty maps. Unpack can also take a 3rd parameter to return a default value when key not found.

# Examples
```elixir
struct = %{player: %{game: %{id: "game-id"}}}
Unpack.get(struct, [:player, :game, :id])
=> "game-id"

struct = %{player: %Ecto.Association.NotLoaded{}}
Unpack.get(struct, [:player, :game, :id])
=> nil

map = %{player: %{}}
Unpack.get(map, [:player, :wrong_key], "eh!")
=> "eh!"
```
Docs can be found at [https://hexdocs.pm/unpack](https://hexdocs.pm/unpack).

## Installation

Available as [Hex package](https://hex.pm/packages/unpack), the package can be installed by adding `unpack` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:unpack, "~> 0.1.6"}
  ]
end
```

## Contributing
Ideas or improvements? Please submit a Github issue.
To submit a PR, please fork this repo first.
