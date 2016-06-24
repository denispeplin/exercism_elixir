defmodule Bob do
  @doc ~S"""
  http://www.pcre.org/pcre.txt
  \p{Lu} always matches an upper case letter
  """
  def hey(input) do
    cond do
      String.ends_with?(input, "?") ->
        "Sure."
      Regex.match?(~r/^[ ]{0,}$/, input) ->
        "Fine. Be that way!"
      Regex.match?(~r/\p{Lu}{2}/u, input) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end
end
