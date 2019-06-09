defmodule PigLatin do
  @vowel_sounds ~w(e o i a u)

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&do_translate/1)
    |> Enum.join(" ")
  end

  defp do_translate(<<first::size(8)>> <> _ = phrase) when first in 'aioue' do
    phrase <> "ay"
  end

  defp do_translate(<<first::size(8)>> <> <<next::size(8)>> <> _last = phrase)
       when first in 'yx' and next not in 'aioue' do
    phrase <> "ay"
  end

  defp do_translate("qu" <> last) do
    last <> "qu" <> "ay"
  end

  defp do_translate(<<first::size(8), "qu", last::binary>>) do
    last <> <<first>> <> "qu" <> "ay"
  end

  defp do_translate(phrase) do
    {first, last} =
      phrase
      |> String.codepoints()
      |> Enum.split_while(fn letter -> letter not in @vowel_sounds end)

    Enum.join(last) <> Enum.join(first) <> "ay"
  end

  defp starts_with_vowel_sound?(phrase) do
    Enum.any?(@vowel_sounds, &String.starts_with?(phrase, &1))
  end
end
