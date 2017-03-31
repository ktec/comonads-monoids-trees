defprotocol Comonad do
  @type t :: any
  @type element :: any

  @spec extend(t, (element -> any)) :: t
  def extend(data, fun)
end
