defmodule CenterSpec do
  use ESpec
  
  describe "Tanga.center with length, padding" do
    it "returns a new string of specified length with self centered and padded with padstr" do
      
      expect Tanga.center("one", 9, ".") |> to(eq "...one...")
      expect Tanga.center("hello", 20, "123") |> to(eq "1231231hello12312312")
      expect Tanga.center("middle", 13, "-") |> to(eq "---middle----")
      
      expect Tanga.center("", 1, "abcd") |> to(eq "a")
      expect Tanga.center("", 2, "abcd") |> to(eq "aa")
      expect Tanga.center("", 3, "abcd") |> to(eq "aab")
      expect Tanga.center("", 4, "abcd") |> to(eq "abab")
      expect Tanga.center("", 6, "xy") |> to(eq "xyxxyx")
      expect Tanga.center("", 11, "12345") |> to(eq "12345123451")
      
      expect Tanga.center("|", 2, "abcd") |> to(eq "|a")
      expect Tanga.center("|", 3, "abcd") |> to(eq "a|a")
      expect Tanga.center("|", 4, "abcd") |> to(eq "a|ab")
      expect Tanga.center("|", 5, "abcd") |> to(eq "ab|ab")
      expect Tanga.center("|", 6, "xy") |> to(eq "xy|xyx")
      expect Tanga.center("|", 7, "xy") |> to(eq "xyx|xyx")
      expect Tanga.center("|", 11, "12345") |> to(eq "12345|12345")
      expect Tanga.center("|", 12, "12345") |> to(eq "12345|123451")
      
      expect Tanga.center("||", 3, "abcd") |> to(eq "||a")
      expect Tanga.center("||", 4, "abcd") |> to(eq "a||a")
      expect Tanga.center("||", 5, "abcd") |> to(eq "a||ab")
      expect Tanga.center("||", 6, "abcd") |> to(eq "ab||ab")
      expect Tanga.center("||", 8, "xy") |> to(eq "xyx||xyx")
      expect Tanga.center("||", 12, "12345") |> to(eq "12345||12345")
      expect Tanga.center("||", 13, "12345") |> to(eq "12345||123451")
    end
  end
end
