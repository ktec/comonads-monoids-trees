defmodule Comonads do
  @moduledoc """
  Documentation for Comonads.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Comonads.hello
      :world

  """
  def hello do
    :world
  end

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
      iex> Comonad.extend(b2, Comonads.changed)
      %Branch{
        annotation: true,
        left: %Branch{
                annotation: false,
                left: %Leaf{annotation: false, value: 1},
                right: %Leaf{annotation: false, value: 2}
              },
        right: %Leaf{annotation: true, value: 3}
      }


  """


  def changed do
    fn tree -> Foldable.reduce(tree, fn (acc, x) -> acc || x end, false) end
  end

end
