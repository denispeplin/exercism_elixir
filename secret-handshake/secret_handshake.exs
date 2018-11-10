defmodule SecretHandshake do
  use Bitwise
  @commands ["wink", "double blink", "close your eyes", "jump"]
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
    do_commands(@commands, code, 0, [])
  end

  def do_commands([], code, index, acc) do
    if (code &&& 0b10000) == 0b10000, do: acc, else: Enum.reverse(acc)
  end

  def do_commands([command | tail], code, index, acc) do
    shift = bsl(1, index)

    acc =
      if (code &&& shift) == shift do
        [command | acc]
      else
        acc
      end

    do_commands(tail, code, index + 1, acc)
  end
end
