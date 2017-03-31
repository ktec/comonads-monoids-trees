defmodule Leaf do
  @moduledoc """
  A leaf.
  """

  keys = [:value, :annotation]
  @enforce_keys keys
  defstruct keys

  @type t :: %__MODULE__{value: number, annotation: any}

  @doc """
  Construct a Leaf node.

      iex> Leaf.new(1, 'wat')
      %Leaf{annotation: 'wat', value: 1}

  """
  @spec new(any, any) :: t
  def new(val, ann) do
    %__MODULE__{value: val, annotation: ann}
  end
end

# defimpl Inspect, for: Leaf do
#   def inspect(%{value: value, annotation: ann}, _) do
#     "Leaf(#{value}, #{ann})"
#   end
# end

defimpl Protocols.Functor, for: Leaf do
  import Leaf
  def map(%{value: value, annotation: ann}, f) do
    new(value, f.(ann))
  end
end

defimpl Protocols.Comonad, for: Leaf do
  import Leaf
  def extend(%{value: value, annotation: ann}, f) do
    new(value, f.(new(value, ann)))
  end
end

defimpl Protocols.Foldable, for: Leaf do
  def reduce(%{value: _value, annotation: ann}, f, acc) do
    f.(acc, ann)
  end
end
