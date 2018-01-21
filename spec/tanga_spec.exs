defmodule TangaSpec do
  use ESpec

  describe "next" do
    it "returns 'abce' for 'abcd'" do
      expect(Tanga.next("abcd")).to eq("abce")
    end
    
    it "returns 'THX1138' for 'THX1139'" do
      expect(Tanga.next("THX1138")).to eq("THX1139")
    end
    
    it "returns '<<koala>>' for '<<koalb>>'" do
      expect(Tanga.next("<<koala>>")).to eq("<<koalb>>")
    end
  end
end
