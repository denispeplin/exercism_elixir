defmodule SecretHandshake do
  @commands ["wink", "double blink", "close your eyes", "jump", :reverse]
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
    list =
      code
      |> Integer.to_string(2)
      |> String.reverse()
      |> String.to_charlist()
      |> Enum.slice(0, 5)
      |> Enum.with_index()
      |> Enum.map(fn {char, index} ->
        if char == ?1 do
          Enum.at(@commands, index)
        else
          ""
        end
      end)
      |> Enum.reject(&(&1 == ""))

    if List.last(list) == :reverse do
      list |> Enum.reverse() |> Enum.slice(1, 4)
    else
      list
    end
  end
end
