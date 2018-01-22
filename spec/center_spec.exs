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
    
    it "pads with whitespace if no padstr is given" do
      expect Tanga.center("two", 5) |> to(eq " two ")
      expect Tanga.center("hello", 20) |> to(eq "       hello        ")
    end
    
    it "returns self if it's longer than or as long as the specified length" do
      expect Tanga.center("", 0) |> to(eq "")
      expect Tanga.center("", -1) |> to(eq "")
      expect Tanga.center("hello", 4) |> to(eq "hello")
      expect Tanga.center("hello", -1) |> to(eq "hello")
      expect Tanga.center("this", 3) |> to(eq "this")
      expect Tanga.center("radiology", 8, "-") |> to(eq "radiology")
    end
    
    it "calls Kernel.trunc to convert length to an integer" do
      expect Tanga.center("_", 3.8, "^") |> to(eq "^_^")
      expect Tanga.center("_", "3", "o") |> to(eq "o_o")
    end
    
    xit "raises a TypeError when padstr can't be converted to a string" do
      expect Tanga.center("hello", 20, 100) |> to(raise_exception TypeError)
      expect Tanga.center("hello", 20, []) |> to(raise_exception TypeError)
      # expect Tanga.center("hello", 20, mock('x')) |> to(raise_exception TypeError)
    end
    
    xit "raises an ArgumentError if padstr is empty" do
      expect Tanga.center("hello", 10, "") |> to(raise_exception ArgumentError)
      expect Tanga.center("hello", 0, "") |> to(raise_exception ArgumentError)
    end
  end
end
