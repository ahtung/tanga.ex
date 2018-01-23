defmodule CenterSpec do
  use ESpec

  describe "" do
    it "center/3" do

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

    it "center/2" do
      expect Tanga.center("two", 5) |> to(eq " two ")
      expect Tanga.center("hello", 20) |> to(eq "       hello        ")
      expect Tanga.center("one", "5") |> to(eq " one ")
      expect Tanga.center("six", 5.4) |> to(eq " six ")
    end

    it "center/2,3 with a string longer than or as long as the specified length" do
      expect Tanga.center("", 0) |> to(eq "")
      expect Tanga.center("", -1) |> to(eq "")
      expect Tanga.center("hello", 4) |> to(eq "hello")
      expect Tanga.center("hello", -1) |> to(eq "hello")
      expect Tanga.center("this", 3) |> to(eq "this")
      expect Tanga.center("radiology", 8, "-") |> to(eq "radiology")
      expect Tanga.center("train", "2", "=") |> to(eq "train")
      expect Tanga.center("cars", 1.5, "+") |> to(eq "cars")
    end

    it "center/3 calls Kernel.trunc to convert length to an integer" do
      expect Tanga.center("_", 3.8, "^") |> to(eq "^_^")
    end

    it "center/3 calls String.to_integer to convert length to an integer" do
      expect Tanga.center("_", "3", "o") |> to(eq "o_o")
    end
  end
end
