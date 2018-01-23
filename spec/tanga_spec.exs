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
  
  describe "squeeze" do
    describe "w/o args" do
      it "returns 'yelow mon' for 'yellow moon'" do
        expect(Tanga.squeeze("yellow moon")).to eq("yelow mon")
      end
      
      it "returns 'gren mon' for 'green moon'" do
        expect(Tanga.squeeze("green moon")).to eq("gren mon")
      end
      
      it "returns 'John Doe №8' for 'John    Doe №88'" do
        expect(Tanga.squeeze("John    Doe №88")).to eq("John Doe №8")
      end
    end
    
    describe "w/ args" do
      it "returns ' now is the' for '  now   is  the'" do
        expect(Tanga.squeeze("  now   is  the", " ")).to eq(" now is the")
      end
      
      it "returns 'puters shot balls' for 'putters shoot balls'" do
        expect(Tanga.squeeze("putters shoot balls", "m-z")).to eq("puters shot balls")
      end
    end
  end
end
