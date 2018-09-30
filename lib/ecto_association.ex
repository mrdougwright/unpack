defmodule Ecto.Association.NotLoaded do
  defstruct [:__field__, :__owner__, :__cardinality__]
  @moduledoc """
  Stubbing to avoid mix dependency on Ecto.
  Hopefully this doesn't overwrite/conflict with Ecto module.
  """
end
