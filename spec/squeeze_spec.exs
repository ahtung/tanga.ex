defmodule SqueezeSpec do
  use ESpec

  describe "Tanga.squeeze" do
    it "returns new string where runs of the same character are replaced by a single character when no args are given" do
      expect(Tanga.squeeze("yellow moon")).to eq("yelow mon")
    end
    
    it "only squeezes chars that are in the intersection of all sets given" do
      expect(Tanga.squeeze("woot squeeze cheese", ["eost", "queo"])).to eq("wot squeze chese")
      expect(Tanga.squeeze("  now   is  the", [" "])).to eq(" now is the")
    end
    
    it "negates sets starting with ^" do
      s = "<<subbookkeeper!!!>>"
      
      # expect(Tanga.squeeze(s, "beko", "^e")).to eq("bko")
      # expect(Tanga.squeeze(s, "^<bek!>")).to eq("o")
      # expect(Tanga.squeeze(s, "^o")).to eq("<bek!>")
      expect(Tanga.squeeze(s, "^")).to eq(s)
      # expect(Tanga.squeeze("^__^", "^^")).to eq("^_^")
      # expect(Tanga.squeeze("((^^__^^))", "_^")).to eq("((^_^))")
    end
    
    it "squeezes all chars in a sequence" do
      s = "--subbookkeeper--"
      
      # expect(Tanga.squeeze(s, "\x00-\xFF")).to eq(Tanga.squeeze(s))
      # expect(Tanga.squeeze(s, "bk-o")).to  eq(Tanga.squeeze(s, "bklmno"))
      # expect(Tanga.squeeze(s, "b-e")).to eq(Tanga.squeeze(s, "bcde"))
      # expect(Tanga.squeeze(s, "e-")).to eq("-subbookkeper-")
      # expect(Tanga.squeeze(s, "-e")).to eq("-subbookkeper-")

      expect(Tanga.squeeze(s, "---")).to eq("-subbookkeeper-")
      expect(Tanga.squeeze("ook--001122", "--2")).to eq("ook-012")
      expect(Tanga.squeeze("ook--(())", "(--")).to eq("ook-()")
      # expect(Tanga.squeeze(s, "^b-e")).to eq("-subbokeeper-")
      # expect(Tanga.squeeze("^^__^^", "^^-^")).to eq("^^_^^")
      # expect(Tanga.squeeze("^^--^^", "^---")).to eq("^--^")

      # expect(Tanga.squeeze(s, "b-dk-o-")).to eq("-subokeeper-")
      # expect(Tanga.squeeze(s, "-b-dk-o")).to eq("-subokeeper-")
      # expect(Tanga.squeeze(s, "b-d-k-o")).to eq("-subokeeper-")

      # expect(Tanga.squeeze(s, "bc-e")).to eq("--subookkeper--")
      # expect(Tanga.squeeze(s, "^bc-e")).to eq("-subbokeeper-")
    
      expect(Tanga.squeeze("AABBCCaabbcc[[]]", "A-a")).to eq("ABCabbcc[]")
    end
    
    it "raises an ArgumentError when the parameter is out of sequence" do
      s = "--subbookkeeper--"
      # expect Tanga.squeeze(s, "e-b") |> to(raise_exception ArgumentError)
      # expect Tanga.squeeze(s, "^e-b") |> to(raise_exception ArgumentError)
    end
    
    # it "taints the result when self is tainted" do
    #   "hello".taint.squeeze("e").tainted?.should == true
    #   "hello".taint.squeeze("a-z").tainted?.should == true
    # 
    #   "hello".squeeze("e".taint).tainted?.should == false
    #   "hello".squeeze("l".taint).tainted?.should == false
    # end
    
    # it "tries to convert each set arg to a string using to_str" do
    #   other_string = mock('lo')
    #   other_string.should_receive(:to_str).and_return("lo")
    # 
    #   other_string2 = mock('o')
    #   other_string2.should_receive(:to_str).and_return("o")
    # 
    #   "hello room".squeeze(other_string, other_string2).should == "hello rom"
    # end
    
    it "raises a TypeError when one set arg can't be converted to a string" do
      # expect Tanga.squeeze("hello world", []) |> to(raise_exception TypeError)
      # expect Tanga.squeeze("hello world", Object.new) |> to(raise_exception TypeError)
      # expect Tanga.squeeze("hello world", mock('x')) |> to(raise_exception TypeError)
    end
  end
end
