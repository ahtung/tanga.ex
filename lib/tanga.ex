defmodule Tanga do
  @moduledoc """
  Tanga is a collection of string helpers similar to those that can be found in Ruby.
  """

  @type t :: binary
  @digits hd('0')..hd('9') |> Enum.to_list |> IO.inspect
  @uppercase_characters hd('A')..hd('A') |> Enum.to_list
  @lowercase_characters hd('a')..hd('z') |> Enum.to_list

  @doc """
  Builds a set of characters from the other_str parameter(s) using the procedure described for String#count. Returns a new string where runs of the same character that occur in this set are replaced by a single character. If no arguments are given, all runs of identical characters are replaced by a single character.

  ## Examples

      iex> Tanga.squeeze("aaa")
      "a"

      iex> Tanga.squeeze("baaabaaa", "a")
      "baba"

      iex> Tanga.squeeze("bbaabbaa", ["a", "b"])
      "baba"

  """
  @spec squeeze(t) :: t
  @spec squeeze(t, t) :: t
  @spec squeeze(t, list) :: t
  def squeeze(string) do
    Regex.replace(~r/(.)\1+/, string, "\\1")
  end

  def squeeze(string, chars) when is_binary(chars) do
    Regex.replace(~r/(|#{chars}|)\1+/, string, "\\1")
  end

  def squeeze(string, chars) when is_list(chars) do
    chars_str = Enum.join(chars, "|")
    Regex.replace(~r/([#{chars_str}])\1+/, string, "\\1")
  end

  @doc """
  Returns the successor to str. The successor is calculated by incrementing characters starting from the rightmost alphanumeric (or the rightmost character if there are no alphanumerics) in the string. Incrementing a digit always results in another digit, and incrementing a letter results in another letter of the same case. Incrementing nonalphanumerics uses the underlying character set’s collating sequence.

  If the increment generates a “carry,” the character to the left of it is incremented. This process repeats until there is no carry, adding an additional character if necessary.

  ## Examples

      iex> Tanga.next("aaa")
      "aab"

      iex> Tanga.next("12")
      "13"

  """
  @spec next(t) :: t
  def next(string) when string == "", do: ""
  def next(string) do
    String.reverse(string)
    |> next_string
    |> String.reverse
  end

  @doc """
  Is an alias to next/1

  ## Examples

      iex> Tanga.succ("9")
      "10"

      iex> Tanga.succ("zz")
      "aaa"

  """
  @spec succ(t) :: t
  defdelegate succ(string), to: __MODULE__, as: :next

  defp next_string("z"), do: "aa"
  defp next_string("Z"), do: "AA"
  defp next_string("9"), do: "01"
  defp next_string(<<byte, rest::bitstring>>) do
    case next_character(byte) do
      {c, true} -> <<c>> <> next_string(rest)
      {c, false} -> <<c>> <> rest
    end
  end

  defp next_character(c) when c in @digits do
    if c + 1 in @digits do
      {c + 1, false}
    else
      {hd(@digits), true}
    end
  end

  defp next_character(c) when c in @lowercase_characters do
    if c + 1 in @lowercase_characters do
      {c + 1, false}
    else
      {hd(@lowercase_characters), true}
    end
  end

  defp next_character(c) when c in @uppercase_characters do
    if c + 1 in @uppercase_characters do
      {c + 1, false}
    else
      {hd(@uppercase_characters), true}
    end
  end

  defp next_character(c) do
    {c, true}
  end

  @doc """
  Centers str in width. If width is greater than the length of str, returns a new String of length width with str centered and padded with padstr; otherwise, returns str.

  ## Examples

      iex> Tanga.center("fin", 9, "~")
      "~~~fin~~~"

  """
  @spec center(t, t, t) :: t
  @spec center(t, float, t) :: t
  @spec center(t, integer, t) :: t
  def center(string, char_count, chars \\ " ")

  def center(string, char_count, chars) when is_binary(char_count) do
    int_char_count = String.to_integer(char_count)
    do_center(string, int_char_count, chars)
  end

  def center(string, char_count, chars) when is_float(char_count) do
    int_char_count = trunc(char_count)
    do_center(string, int_char_count, chars)
  end

  def center(string, char_count, chars) when is_integer(char_count) do
    do_center(string, char_count, chars)
  end

  defp do_center(string, char_count, chars) do
    string_length = String.length(string)
    if char_count <= string_length do
      string
    else
      space = char_count - string_length
      lpad = round(Float.floor(space / 2))
      rpad = round(Float.ceil(space / 2))
      String.pad_trailing(string, max(0, rpad) + string_length, chars)
      |> String.pad_leading(char_count, chars)
    end
  end

  @doc """
  Inverts all characters in the given string to uppercase/lowercase accordingly

  ## Examples

      iex> Tanga.swapcase("aBcD")
      "AbCd"

      iex> Tanga.swapcase("aB 123 xPTo")
      "Ab 123 XptO"

      iex> Tanga.swapcase("oLá")
      "OlÁ"

  """
  @spec swapcase(t) :: t
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
