# Unpack

This tiny Elixir drop comes with two main functions.

`get` lets you reach in and unpack any value from a nested map. Returns nil for bad or missing keys, unloaded associations, or empty maps. `get` can also take a 3rd parameter to return a default value when key not found.

`from_struct` lets you transform deeply nested structs to maps.

# Examples
## Using `get`
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
## Using `from_struct`
```elixir
defmodule Company do
  defstruct [:products]
end

defmodule Product do
  defstruct [:name, :amount]
end

defmodule Money do
  defstruct [:currency, :value]
end

item1 = %Product{name: "gold", amount: 2}
item2 = %Product{name: "silver", amount: %Money{currency: "USD", value: 1}}
struct = %Company{products: [item1, item2]}

Unpack.from_struct(struct)
=> %{
      products: [
        %{amount: 2, name: "gold"},
        %{amount: %{currency: "USD", value: 1}, name: "silver"}
      ]
    }
```
Docs can be found at [https://hexdocs.pm/unpack](https://hexdocs.pm/unpack).

## Installation

Available as [Hex package](https://hex.pm/packages/unpack), the package can be installed by adding `unpack` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:unpack, "~> 0.1.7"}
  ]
end
```

## Contributing
Ideas or improvements? Please submit a Github issue.
To submit a PR, please fork this repo first.
