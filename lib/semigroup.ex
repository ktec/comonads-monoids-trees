defprotocol Semigroup do
  @moduledoc """
  A semigroup is concatable.
  """

  @type t :: any

  @spec concat(t, t) :: t
  def concat(a, b)
end
