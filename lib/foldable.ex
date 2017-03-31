defmodule Foldable.Guard do
  defmacro is_foldable(maybe_foldable) do
    case Macro.Env.in_guard? __CALLER__ do
      true -> quote do
        unquote(maybe_foldable)
      end
      false -> quote do
        raise ArgumentError, "The is a guard clause. What you be doing?"
      end
    end
  end
end

defprotocol Foldable do
  @moduledoc """
  A Foldable type is also a container.
  """

  @type t :: any
  @type element :: any

  @spec reduce(t, (element -> any), any) :: any
  def reduce(data, fun, acc)
end
