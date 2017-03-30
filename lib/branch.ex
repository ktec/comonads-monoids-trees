defmodule Branch do
  @moduledoc """
  A branch.
  """

  alias Functor

  keys = [:left, :right, :annotation]
  @enforce_keys keys
  defstruct keys

  @type t :: %__MODULE__{left: Leaf.t | Branch.t,
                         right: Leaf.t | Branch.t,
                         annotation: any}

  @doc """
  Construct a Branch node.

      iex> l1 = Leaf.new(1, 'wat')
      iex> r1 = Leaf.new(2, 'do')
      iex> Branch.new(l1, r1, 'wat')
      %Branch{annotation: 'wat', left: %Leaf{annotation: 'wat', value: 1},
      right: %Leaf{annotation: 'do', value: 2}}

  """
  @spec new(any, any, any) :: t
  def new(left, right, ann) do
    %__MODULE__{left: left, right: right, annotation: ann}
  end
end

defimpl Functor, for: Branch do
  def map(%{left: left, right: right, annotation: ann}, f) do
    Branch.new(Functor.map(left, f), Functor.map(right, f), f.(ann))
  end
end

defimpl Comonad, for: Branch do
  def extend(%{left: left, right: right, annotation: ann}, f) do
    Branch.new(Comonad.extend(left, f), Comonad.extend(right, f), f.(Branch.new(left, right, ann)))
  end
end

defimpl Foldable, for: Branch do
  def reduce(%{left: left, right: right, annotation: ann}, f, acc) do
    Foldable.reduce(right, f, Foldable.reduce(left, f, f.(acc, ann)))
  end
end
