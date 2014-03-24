require 'spec_helper'

module Shopping
  
  describe Taxes do
    let(:taxes)   {Taxes.new}
    
    describe "Calculate amount rounded up to the nearest 5 cents (decimal)" do
    
      context "amounts already at 5 and 10 cent marks shouldn't change" do
        
        it "should round up 10.0 to 10.0" do
          taxes.to_nearest_five_cents_rounded_up(10.0).should == 10.0
        end
        
        it "should round up 10.5 to 10.5" do
          taxes.to_nearest_five_cents_rounded_up(10.5).should == 10.5
        end
        
        it "should round up 10.1 to 10.10" do
          taxes.to_nearest_five_cents_rounded_up(10.1).should == 10.10
        end       
        
      end
 
      context "other amounts should grow to the nears 5 cents (decimal)" do
        
        it "should round up 2.98 to 3.00" do
          taxes.to_nearest_five_cents_rounded_up(2.98).should == 3.00
        end
        
        it "should round up 7.125 to 7.15" do
          taxes.to_nearest_five_cents_rounded_up(7.125).should == 7.15
        end
        
        it "should round up 10.11 to 10.15" do
          taxes.to_nearest_five_cents_rounded_up(10.11).should == 10.15
        end
        
      end     
    end   # End of Calculate amount rounded up to the nearest 5 cents (decimal) Describe
 
    describe "Appropriate tax rate when import and tax_exempt status are known -- " do
           
      it "should have no taxes on domestic books, food, and medical products" do
        imported = false
        tax_exempt = true
        taxes.tax_rate(imported, tax_exempt).should == 0.0
      end   
    
     
      it "should have a small 0.05 tax on imported books, food, and medical products" do
        imported = true
        tax_exempt = true
        taxes.tax_rate(imported, tax_exempt).should == 0.05
      end   
    
      it "should have a medium 0.10 tax on domestic music CDs, and perfumes " do
        imported = false
        tax_exempt = false
        taxes.tax_rate(imported, tax_exempt).should == 0.10
      end   

      it "should have a high 0.15 tax on imported music CDs, and perfumes " do
        imported = true
        tax_exempt = false
        taxes.tax_rate(imported, tax_exempt).should be_close(0.15, 0.005)
      end 
    end  # End of Determine appropriate tax rate Describe
    
    describe "Determine Import and Tax Exempt status based on products description" do
      
      context "imported and non imported products are correctly identified" do
 
        it "should know these chocolates are imported" do
          taxes.is_imported?("imported box of chocolates").should == true
        end
        
        it "should know this perfume is imported" do
          taxes.is_imported?("1 imported bottle of perfume at 27.99").should == true
        end
        
        it "should know these chocolates are NOT imported" do
          taxes.is_imported?("chocolate bar").should == false
        end
      
      end
      
      context "tax exempt and non tax exempt products are correctly identified" do
        
        it "should know perfume is NOT tax emempt" do
          taxes.is_tax_exempt?("1 imported bottle of perfume at 27.99").should == false
        end
        
        it "should know books are tax emempt" do
          taxes.is_tax_exempt?("book").should == true
        end
      
        it "should know food we sell is tax emempt" do
          taxes.is_tax_exempt?("imported box of chocolates").should == true
        end
        
        it "should know medicines we sell are tax emempt" do
          taxes.is_tax_exempt?("headache pills").should == true
        end
      
      end
      
    end  # End of Determine appropriate tax rate Describe
     
  end # End of Taxes Describe
  
end  # End of Module