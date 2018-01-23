defmodule SwapcaseSpec do
  use ESpec, async: true

  describe "" do
    it "swapcase/1" do
      expect Tanga.swapcase("Hello") |> to(eq "hELLO")
      expect Tanga.swapcase("cYbEr_PuNk11") |> to(eq "CyBeR_pUnK11")
      expect Tanga.swapcase("+++---111222???") |> to(eq "+++---111222???")
      expect Tanga.swapcase("") |> to(eq "")
      assert Tanga.swapcase("123 aBCd 456 eFg hIj ( %$#) kL mnOp @ qrst = -_ uvwxyz") |> to(eq"123 AbcD 456 EfG HiJ ( %$#) Kl MNoP @ QRST = -_ UVWXYZ")
    end

    it "swapcase/1 with UTF-8" do
      expect Tanga.swapcase("& % # àÁâ ãÄå 1 2 ç Æ") |> to(eq "& % # ÀáÂ ÃäÅ 1 2 Ç æ")
      expect Tanga.swapcase("àáâãäåæÇÈÉÊËìíîïðÑÒÓÔÕÖøùúûüýþ") |> to(eq "ÀÁÂÃÄÅÆçèéêëÌÍÎÏÐñòóôõöØÙÚÛÜÝÞ")
    end

    it "swapcase/1 with UTF-8 multibyte" do
      expect Tanga.swapcase("straße") |> to(eq "STRASSE")
      expect Tanga.swapcase("áÜÈß") |> to(eq "ÁüèSS")
    end
  end
end
