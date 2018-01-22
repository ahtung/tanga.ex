defmodule SwapcaseSpec do
  use ESpec

  describe "Tanga.swapcase" do
    it "returns a new string with all uppercase chars from self converted to lowercase and vice versa" do
      expect Tanga.swapcase("Hello") |> to(eq "hELLO")
      expect Tanga.swapcase("cYbEr_PuNk11") |> to(eq "CyBeR_pUnK11")
      expect Tanga.swapcase("+++---111222???") |> to(eq "+++---111222???")
    end
    
    it "works for all of Unicode" do
      expect Tanga.swapcase("äÖü") |> to(eq "ÄöÜ")
    end
  end
end
