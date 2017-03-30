defprotocol Comonad do
  @type t :: any
  @type element :: any

  @spec extend(Comonad.t, (element -> any)) :: Comonad.t
  def extend(data, fun)
end
