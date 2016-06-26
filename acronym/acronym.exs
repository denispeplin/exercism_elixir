defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.replace(~r/[\s\t]+/, string, " ")
    |> _abbreviate([], true)
  end
  defp _abbreviate("", acc, _) do
    Enum.join acc
  end
  defp _abbreviate(string, acc, false) do
    { grapheme, reminder } = String.next_grapheme string
    _abbreviate reminder, acc ++ Regex.scan(~r/^\p{Lu}$/u, grapheme), grapheme == " "
  end
  defp _abbreviate(string, acc, true) do
    { grapheme, reminder } = String.next_grapheme string
    _abbreviate reminder, acc ++ [String.upcase(grapheme)], false
  end
end
