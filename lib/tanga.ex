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

  ## Examples

    iex> Tanga.squeeze("fiiin", "i)
    "fin"

  """
  @spec squeeze(t, t) :: t
  def squeeze(string, chars \\ ".")

  def squeeze(string, chars) when is_binary(chars) do
    do_squeeze(string, List.wrap(chars))
  end

  def squeeze(string, chars) when is_list(chars) do
    do_squeeze(string, chars)
  end

  defp do_squeeze(string, chars) do
    string_list = string |> String.graphemes
    char_list = chars
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&(MapSet.new(&1)))
      |> Enum.reduce(nil, fn(pieces, acc) ->
        if acc == nil do
          MapSet.new(pieces)
        else
          MapSet.intersection(acc, pieces)
        end
      end)
      |> MapSet.to_list

    string_list
      |> Enum.reduce(string, fn(x, acc) ->
        Regex.replace(~r/#{x}+/, acc, x)
      end)
  end

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
  Centers str in width. If width is greater than the length of str, returns a new String of length width with str centered and padded with padstr; otherwise, returns str.
  """
  def swapcase(string) do
    string
      |> String.graphemes
      |> Enum.map(fn(char) ->
        if char =~ ~r/^\p{Lu}$/u do
          String.downcase(char)
        else
          String.upcase(char)
        end
      end)
      |> Enum.join
  end
end
