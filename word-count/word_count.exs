defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    String.downcase(sentence)
    |> String.split(~r/[ _:\!&@\$%\^,]{1,}/u, trim: true)
    |> Enum.sort
    |> Enum.chunk_by(fn word -> word end)
    |> Enum.map(fn chunk -> { List.first(chunk), Enum.count(chunk) } end)
    |> Enum.into(%{})
  end
end
