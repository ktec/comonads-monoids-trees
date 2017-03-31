defmodule Composition do
  @moduledoc """
  Documentation for Composition.
  """

  @doc """
  Reduce tree annotations to a single value.

      iex> l1 = Leaf.new(1, false)
      %Leaf{annotation: false, value: 1}
      iex> l2 = Leaf.new(2, false)
      %Leaf{annotation: false, value: 2}
      iex> l3 = Leaf.new(3, true)
      %Leaf{annotation: true, value: 3}
      iex> b1 = Branch.new(l1, l2, false)
      %Branch{
        annotation: false,
        left: %Leaf{annotation: false, value: 1},
        right: %Leaf{annotation: false, value: 2}
      }
      iex> b2 = Branch.new(b1, l3, false)
      %Branch{
        annotation: false,
        left: %Branch{
                annotation: false,
                left: %Leaf{annotation: false, value: 1},
                right: %Leaf{annotation: false, value: 2}
              },
        right: %Leaf{annotation: true, value: 3}
      }
      iex> Comonad.extend(b2, &Composition.changed/1)
      %Branch{annotation: true,
        left: %Branch{annotation: false,
         left: %Leaf{annotation: false, value: 1},
         right: %Leaf{annotation: false, value: 2}},
        right: %Leaf{annotation: true, value: 3}}


  """

  # @spec changed(Foldable.t) :: any
  # def changed(tree) do
  #   Foldable.reduce(tree, fn (acc, x) -> acc || x end, false)
  # end

  # @spec changed(Foldable.t) :: any
  # def changed(tree) do
  #   alias Types.Any, as: Any
  #   %Any{value: value} = tree |> Functor.map(&Any.new/1) |> fold()
  #   value
  # end
  #
  # @spec fold(Foldable.t) :: any
  # def fold(%{annotation: ann} = foldable) do
  #   Foldable.reduce(foldable, &Semigroup.concat/2, Monoid.empty(ann))
  # end

  alias Types.Any, as: Any

  @spec changed(Foldable.t) :: any
  def changed(tree) do
    %Any{value: value} = foldMap(&Any.new/1, tree)
    value
  end

  def foldMap(f, %{annotation: ann} = foldable) do
    Foldable.reduce(
      foldable,
      fn (acc, x) -> Semigroup.concat(acc, f.(x)) end,
      Monoid.empty(f.(ann))
    )
  end

  def create_tree do
    l1 = Leaf.new(1, false)
    l2 = Leaf.new(2, false)
    l3 = Leaf.new(3, true)
    b1 = Branch.new(l1, l2, false)
    b2 = Branch.new(b1, l3, false)
    b2
    #Comonad.extend(b2, &changed/1)
  end
end
