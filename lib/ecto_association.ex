defmodule Ecto.Association.NotLoaded do
  defstruct [:stubbing]
  @moduledoc false
  # Stubbing to avoid mix dependency on Ecto.
  # This does throw warnings...
end
