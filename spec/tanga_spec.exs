defmodule TangaSpec do
  use ESpec

  describe "next" do
    it "returns 'abce' for 'abcd'" do
      expect(Tanga.next("abcd")).to eq("abce")
    end
  end
end
