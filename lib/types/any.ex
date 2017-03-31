defmodule Types.Any do
  keys = [:value]
  @enforce_keys keys
  defstruct keys

  @type t :: %__MODULE__{value: boolean}

  @doc """
  Construct a Boolean.

      iex> Any.new(true)
      %Any{value: true}

  """
  @spec new(boolean) :: t
  def new(val) do
    %__MODULE__{value: val}
  end
end

# defimpl Inspect, for: Types.Any do
#   def inspect(%{value: value}, _) do
#     "#{value}"
#   end
# end

defimpl Semigroup, for: Types.Any do
  alias Types.Any, as: Any
  def concat(%Any{value: value}, %Any{value: other}) do
    Any.new(value || other)
  end
end

defimpl Monoid, for: Types.Any do
  alias Types.Any, as: Any
  def empty(%Any{}) do
    Any.new(false)
  end
end
