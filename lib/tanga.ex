defmodule Tanga do
  @moduledoc """
  Documentation for Tanga.
  """
  
  @character_ranges [
    {'a', 'z'},
    {'0', '9'}
  ]
  @characters Enum.map(@character_ranges, fn {a, z} ->
                hd(a)..hd(z)
                  |> Enum.to_list
              end)
                |> List.flatten

  @doc """
  Returns the successor to str. The successor is calculated by incrementing characters starting from the rightmost alphanumeric (or the rightmost character if there are no alphanumerics) in the string. Incrementing a digit always results in another digit, and incrementing a letter results in another letter of the same case. Incrementing nonalphanumerics uses the underlying character set’s collating sequence.

  If the increment generates a “carry,” the character to the left of it is incremented. This process repeats until there is no carry, adding an additional character if necessary.
  """
  def next(string) do
    String.reverse(string)
      |> next_string
      |> String.reverse
  end
  
  defp next_string(<<byte, rest::bitstring>>) do
    case next_character(byte) do
      {c, true} -> <<c>> <> next_string(rest)
      {c, false} -> <<c>> <> rest
    end
  end
  
  defp next_character(c) when c in @characters do
    if (c + 1) in @characters do
      {c + 1, false}
    else
      index = Enum.find_index(@characters, &(&1 == c))

      if c = Enum.at(@characters, index + 1) do
        {c, false}
      else
        {hd(@characters), true}
      end
    end
  end

  defp next_character(c), do: {c, true}
end
