defmodule TangaSpec do
  use ESpec
  doctest Tanga

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
    
    xit "returns '2000aaa' for '1999zzz'" do
      expect(Tanga.next("1999zzz")).to eq("2000aaa")
    end
    
    xit "returns 'ZZZ9999' for 'AAAA0000'" do
      expect(Tanga.next("ZZZ9999")).to eq("AAAA0000")
    end
    
    xit "returns '**+' for '***'" do
      expect(Tanga.next("***")).to eq("**+")
    end
  end
end
