defmodule SqueezeSpec do
  use ESpec, async: true

  describe "" do
    it "squeeze/1" do
      expect(Tanga.squeeze("yellow moon")).to eq("yelow mon")
    end

    it "squeeze/2 with a list" do
      expect(Tanga.squeeze("woot squeeze cheese", ["eost", "queo"])).to eq("wot squeze chese")
      expect(Tanga.squeeze("  now   is  the", [" "])).to eq(" now is the")
    end

    xit "negates sets starting with ^" do
      s = "<<subbookkeeper!!!>>"

      expect(Tanga.squeeze(s, ["beko", "^e"])).to eq("<<subokeeper!!!>>")
      expect(Tanga.squeeze(s, "^<bek!>")).to eq("<<subbokkeeper!!!>>")
      expect(Tanga.squeeze(s, "^o")).to eq("<bek!>")
      expect(Tanga.squeeze(s, "^")).to eq(s)
      expect(Tanga.squeeze("^__^", "^^")).to eq("^_^")
      expect(Tanga.squeeze("((^^__^^))", "_^")).to eq("((^_^))")
    end

    xit "squeezes all chars in a sequence" do
      s = "--subbookkeeper--"

      expect(Tanga.squeeze(s, "\x00-\xFF")).to eq(Tanga.squeeze(s))
      expect(Tanga.squeeze(s, "bk-o")).to  eq(Tanga.squeeze(s, "bklmno"))
      expect(Tanga.squeeze(s, "b-e")).to eq(Tanga.squeeze(s, "bcde"))
      expect(Tanga.squeeze(s, "e-")).to eq("-subbookkeper-")
      expect(Tanga.squeeze(s, "-e")).to eq("-subbookkeper-")

      expect(Tanga.squeeze(s, "---")).to eq("-subbookkeeper-")
      expect(Tanga.squeeze("ook--001122", "--2")).to eq("ook-012")
      expect(Tanga.squeeze("ook--(())", "(--")).to eq("ook-()")
      expect(Tanga.squeeze(s, "^b-e")).to eq("-subbokeeper-")
      expect(Tanga.squeeze("^^__^^", "^^-^")).to eq("^^_^^")
      expect(Tanga.squeeze("^^--^^", "^---")).to eq("^--^")

      expect(Tanga.squeeze(s, "b-dk-o-")).to eq("-subokeeper-")
      expect(Tanga.squeeze(s, "-b-dk-o")).to eq("-subokeeper-")
      expect(Tanga.squeeze(s, "b-d-k-o")).to eq("-subokeeper-")

      expect(Tanga.squeeze(s, "bc-e")).to eq("--subookkeper--")
      expect(Tanga.squeeze(s, "^bc-e")).to eq("-subbokeeper-")

      expect(Tanga.squeeze("AABBCCaabbcc[[]]", "A-a")).to eq("ABCabbcc[]")
    end
  end
end
