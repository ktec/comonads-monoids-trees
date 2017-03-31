defprotocol Monoid do
  @moduledoc """
  A monoid is a semigroup with empty.
  """

  @type t :: any

  @spec empty(t) :: t
  def empty(t)
end
