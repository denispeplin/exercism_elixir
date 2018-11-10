defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  0001 = wink
  0010 = double blink
  0100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> wink(code)
    |> double_blink(code)
    |> close_eyes(code)
    |> jump(code)
    |> reverse(code)
  end

  defp wink(list, code) do
    if (code &&& 0b1) == 0b1, do: ["wink" | list], else: list
  end

  defp double_blink(list, code) do
    if (code &&& 0b10) == 0b10, do: ["double blink" | list], else: list
  end

  defp close_eyes(list, code) do
    if (code &&& 0b100) == 0b100, do: ["close your eyes" | list], else: list
  end

  defp jump(list, code) do
    if (code &&& 0b1000) == 0b1000, do: ["jump" | list], else: list
  end

  defp reverse(list, code) do
    if (code &&& 0b10000) == 0b10000, do: list, else: Enum.reverse(list)
  end
end
