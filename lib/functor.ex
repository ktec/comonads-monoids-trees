defprotocol Functor do
  @type t :: any
  @type element :: any

  @spec map(t, (element -> any)) :: t
  def map(data, fun)
end
