require "codebreaker"

module Codebreaker

  describe Maker do

    describe "#exact_match_count" do

      context "with no matches" do 
        it "return 0" do
          maker = Maker.new("1234", "5555")
          maker.exact_match_count.should == 0
        end
      end

      context "with 1 exact match" do
        it "return 1" do
          maker = Maker.new("1234", "1555")
          maker.exact_match_count.should == 1         
        end
      end

      context "with 1 number match" do
        it "return 0" do 
          maker = Maker.new("1234", "5155")
          maker.exact_match_count.should == 0     
        end
      end

      context "with 1 exact match and 1 number match" do
        it "return 1" do 
          maker = Maker.new("1234", "1525")
          maker.exact_match_count.should == 1     
        end
      end      

    end

    describe "#number_match_count" do

      context "with no matches" do 
        it "return 0" do
          maker = Maker.new("1234", "5555")
          maker.number_match_count.should == 0
        end
      end

      context "with 1 exact match" do
        it "return 0" do
          maker = Maker.new("1234", "1555")
          maker.number_match_count.should == 0         
        end
      end

      context "with 1 number match" do
        it "return 1" do 
          maker = Maker.new("1234", "5155")
          maker.number_match_count.should == 1     
        end
      end

      context "with 1 exact match and 1 number match" do
        it "return 1" do 
          maker = Maker.new("1234", "1525")
          maker.number_match_count.should == 1     
        end
      end      

    end    



  end
end