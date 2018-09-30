# Unpack

This tiny Elixir drop let's you reach in and unpack any value from a nested map. Returns nil for bad keys, unloaded associations, or empty maps.

# Dependencies

This library doesn't have any dependencies. However, to avoid depending on Ecto while still catching %Ecto.Assocation.NotLoaded{} values, I have stubbed the module. Be sure to place `:ecto` dependency in your deps function where it won't get overwritten :)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `unpack` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:unpack, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/unpack](https://hexdocs.pm/unpack).
