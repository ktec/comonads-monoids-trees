defprotocol Protocols.Comonad do
  @moduledoc """
  A branch.
  """

  @type t :: any
  @type element :: any

  @spec extend(t, (element -> any)) :: t
  def extend(data, fun)
end
