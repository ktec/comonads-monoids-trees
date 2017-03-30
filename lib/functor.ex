defprotocol Functor do
  @type t :: any
  @type element :: any

  @spec map(Functor.t, (element -> any)) :: Functor.t
  def map(data, fun)
end
