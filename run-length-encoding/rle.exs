defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.graphemes
    |> Enum.chunk_by(fn grapheme -> grapheme end)
    |> Enum.map(fn graphemes -> Enum.join([Enum.count(graphemes), List.first(graphemes)]) end)
    |> Enum.join
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
    |> String.graphemes
    |> Enum.chunk_by(fn grapheme -> Integer.parse(grapheme) != :error end)
    |> Enum.map(&Enum.join/1)
    |> Enum.chunk(2)
    |> parse_numbers([])
    |> Enum.reverse
    |> Enum.join
  end

  @doc """
  Converts [["12", "W"], ["3", "A"]] to ["AAA", "WWWWWWWWWWWW"]
  """
  defp parse_numbers([], acc), do: acc
  defp parse_numbers([head | tail], acc) do
    [num, letter] = head
    parse_numbers(tail, [String.duplicate(letter, String.to_integer(num)) | acc])
  end
end
