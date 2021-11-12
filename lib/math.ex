defmodule ElixirStartingPoint.Math do
  @moduledoc "Various mathematical helpers"

  @doc """
  An implementation of C's fmod() --- modular division on floating point values

  Example:

    iex> Float.round(ElixirStartingPoint.Math.fmod(9.87654321, 9), 3)
    0.877
  """
  @spec fmod(float, number) :: float
  def fmod(input, max) when is_float(input) do
    input - max * trunc(input / max)
  end
end
