defprotocol Foldable do
  @moduledoc """
  A Foldable type is also a container.
  """

  @type t :: any
  @type element :: any

  @spec reduce(Foldable.t, (element -> any), any) :: any
  def reduce(data, fun, acc)
end
