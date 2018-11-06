defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun, acc \\ [])
  def keep([], _fun, acc), do: Enum.reverse(acc)

  def keep([elem | list], fun, acc) do
    if fun.(elem) do
      keep(list, fun, [elem | acc])
    else
      keep(list, fun, acc)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun), do: keep(list, &(!fun.(&1)))
end
