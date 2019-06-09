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
    if starts_with_vowel_sound?(phrase) do
      phrase <> "ay"
    else
      phrase
    end
  end

  defp starts_with_vowel_sound?(phrase) do
    Enum.any?(@vowel_sounds, &String.starts_with?(phrase, &1))
  end
end
