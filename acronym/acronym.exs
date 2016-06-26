defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    _abbreviate(string, [])
  end
  defp _abbreviate("", acc) do
    Enum.join acc
  end
  defp _abbreviate(string, acc) do
    { grapheme, reminder } = String.next_grapheme string
    _abbreviate reminder, acc ++ Regex.scan(~r/^\p{Lu}$/u, grapheme)
  end
end
