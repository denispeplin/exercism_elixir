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
    0..3
    |> Enum.map(fn index ->
      shift = bsl(1, index)

      if (code &&& shift) == shift do
        Enum.at(@commands, index)
      end
    end)
    |> Enum.filter(& &1)
    |> reverse(code)
  end

  defp reverse(list, code) do
    if (code &&& 0b10000) == 0b10000, do: Enum.reverse(list), else: list
  end
end
