defmodule NextSpec do
  use ESpec, async: true

  describe "" do
    it "next/1" do
      expect Tanga.next("") |> to(eq "")
    end
    
    it "next/1 with ..." do
      expect Tanga.next("abcd") |> to(eq "abce")
      expect Tanga.next("THX1138") |> to(eq "THX1139")

      expect Tanga.next("<<koala>>") |> to(eq "<<koalb>>")
      # expect Tanga.next("==A??") |> to(eq "==B??")
    end
    
    xit "next/1 with non-alphanumerics" do
      expect Tanga.next("***") |> to(eq "**+")
      expect Tanga.next("**`") |> to(eq "**a")
    end
    
    it "increases the next best alphanumeric (jumping over non-alphanumerics) if there is a carry" do
      expect Tanga.next("dz") |> to(eq "ea")
#      expect Tanga.next("HZ") |> to(eq "IA")
      expect Tanga.next("49") |> to(eq "50")

      expect Tanga.next("izz") |> to(eq "jaa")
#      expect Tanga.next("IZZ") |> to(eq "JAA")
      expect Tanga.next("699") |> to(eq "700")
#
#      expect Tanga.next("6Z99z99Z") |> to(eq "7A00a00A")
#
      expect Tanga.next("1999zzz") |> to(eq "2000aaa")
#      expect Tanga.next("NZ/[]ZZZ9999") |> to(eq "OA/[]AAA0000")
    end
    
    xit "increases the next best character if there is a carry for non-alphanumerics" do
      expect Tanga.next("(\xFF") |> to(eq ")\x00")
      expect Tanga.next("`\xFF") |> to(eq "a\x00")
      expect Tanga.next("<\xFF\xFF") |> to(eq "=\x00\x00")
    end
    
    xit "adds an additional character (just left to the last increased one) if there is a carry and no character left to increase" do
      expect Tanga.next("z") |> to(eq "aa")
      expect Tanga.next("Z") |> to(eq "AA")
      expect Tanga.next("9") |> to(eq "10")

      expect Tanga.next("zz") |> to(eq "aaa")
      expect Tanga.next("ZZ") |> to(eq "AAA")
      expect Tanga.next("99") |> to(eq "100")
      
      expect Tanga.next("9Z99z99Z") |> to(eq "10A00a00A")

      expect Tanga.next("ZZZ9999") |> to(eq "AAAA0000")
      expect Tanga.next("/[]9999") |> to(eq "/[]10000")
      expect Tanga.next("/[]ZZZ9999") |> to(eq "/[]AAAA0000")
      expect Tanga.next("Z/[]ZZZ9999") |> to(eq "AA/[]AAA0000")

      # non-alphanumeric cases
      expect Tanga.next("\xFF") |> to(eq "\x01\x00")
      expect Tanga.next("\xFF\xFF") |> to(eq "\x01\x00\x00")
    end
  end
end
