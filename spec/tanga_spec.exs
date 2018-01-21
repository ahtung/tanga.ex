defmodule TangaSpec do
  use ESpec

  describe "next" do
    it "returns 'abce' for 'abcd'" do
      expect(Tanga.next("abcd")).to eq("abce")
    end
    
    it "returns 'abce' for 'abcd'" do
      expect(Tanga.next("THX1138")).to eq("THX1139")
    end
  end
end
