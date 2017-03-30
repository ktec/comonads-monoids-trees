defmodule Leaf do
  @moduledoc """
  A leaf.
  """

  alias Functor

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

defimpl Functor, for: Leaf do
  def map(%{value: value, annotation: ann}, f) do
    Leaf.new(value, f.(ann))
  end
end

defimpl Comonad, for: Leaf do
  def extend(%{value: value, annotation: ann}, f) do
    Leaf.new(value, f.(Leaf.new(value, ann)))
  end
end

defimpl Foldable, for: Leaf do
  def reduce(%{value: _value, annotation: ann}, f, acc) do
    f.(acc, ann)
  end
end
