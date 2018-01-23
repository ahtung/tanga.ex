defmodule Tanga do
  @moduledoc """
  Documentation for Tanga.
  """
  
  @type t :: binary
  
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
  Builds a set of characters from the other_str parameter(s) using the procedure described for String#count. Returns a new string where runs of the same character that occur in this set are replaced by a single character. If no arguments are given, all runs of identical characters are replaced by a single character.
  """
  def squeeze(string) do
    string
      |> String.graphemes
      |> squeeze_string
      |> Enum.join
  end
  
  def squeeze(string, chars) do
    graphemes = string |> String.graphemes
    split = chars |> String.split("", trim: true)
    case split do
      [from, "-", to] ->
        range = hd(to_charlist(from))..hd(to_charlist(to))
          |> Enum.to_list
          |> to_string
          |> String.split("", trim: true)
        squeeze_string(graphemes, range)
      [char] ->
        squeeze_string(graphemes, [char])
    end
      |> Enum.join
  end

  defp squeeze_string([h|t], chars) do
    if h == List.first(t) && Enum.member?(chars, h) do
      squeeze_string(t, chars)
    else
      [h] ++ squeeze_string(t, chars)
    end
  end
  
  defp squeeze_string(last, chars), do: last
    
  defp squeeze_string([h|t]) do
    if h == List.first(t) do
      squeeze_string(t)
    else
      [h] ++ squeeze_string(t)
    end
  end
  
  defp squeeze_string(last), do: last

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
  
  @doc """
  Centers str in width. If width is greater than the length of str, returns a new String of length width with str centered and padded with padstr; otherwise, returns str.
  """
  def center(string, char_count) do
    center(string, char_count, " ")
  end
  
  def center(string, char_count, chars) do
    string_length = String.length(string)
    space = char_count - string_length
    lpad = round(Float.floor(space / 2))
    rpad = round(Float.ceil(space / 2))
    String.pad_trailing(string, max(0, rpad) + string_length, chars)
      |> String.pad_leading(char_count, chars)
  end
  
  @doc """
  Inverts all characters in the given string to uppercase/lowercase accordingly

  ## Examples

      iex> Tanga.swapcase("abcd")
      "ABCD"

      iex> Tanga.swapcase("ab 123 xpto")
      "AB 123 XPTO"

      iex> Tanga.swapcase("olá")
      "OLÁ"

  """
  @spec swapcase(t) :: t
  def swapcase(string)

  def swapcase(string) when is_binary(string) do
    string
      |> String.graphemes
      |> Enum.map(fn(char) ->
        if char =~ ~r/^\p{Lu}$/u,
          do: String.downcase(char),
          else: String.upcase(char)
      end)
      |> Enum.join
  end
end
