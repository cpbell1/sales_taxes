require 'spec_helper'

module Shopping
  
  describe LineItem do
    
    describe "Builds a line item from an input string" do
    
      context "a simple line item should know its name, quanity and price" do
        let(:purchase) { LineItem.new("1 book at 12.49") }
        
        it "should have a name of 'book'" do         
          purchase.name.should == 'book'
        end
        
        it "should have a quanity of 1" do
          purchase.quantity.should == 1
        end
        
        it "should have a price of 12.49" do
          purchase.price.should == 12.49
        end       
      end
    
      context "a more complex line item should also know its name, quanity and price" do
        let(:purchase) { LineItem.new("2 imported bottles of perfume at 47.50") }
        
        it "should have a name of 'imported bottles of perfume'" do         
          purchase.name.should == 'imported bottles of perfume'
        end
        
        it "should have a quanity of 2" do
          purchase.quantity.should == 2
        end
        
        it "should have a price of 47.50" do
          purchase.price.should == 47.50
        end
      end
    
      context "imported purfume should know it is imported and taxable" do
        let(:purchase) { LineItem.new("2 imported bottles of perfume at 47.50") }
        
        it "should know it is imported'" do         
          purchase.import_taxable.should == true
        end
        
        it "should know it is taxable" do         
          purchase.free_of_domestic_tax.should == false
        end    
      end
    
      context "a chocolate bar should know it is NOT imported and is tax taxable" do
        let(:purchase) { LineItem.new("1 chocolate bar at 0.85") }
        
        it "should know it is NOT imported" do         
          purchase.import_taxable.should == false
        end
        
        it "should know it is tax free" do         
          purchase.free_of_domestic_tax.should == true
        end    
      end
    
    end  # End of Builds a line item from an input string
    
    describe "Calculate taxes and totals for a line item" do
    
      context "a simple line item should know its name, quanity and price" do
        
        it "should know it has no tax" do
          purchase =  LineItem.new("1 chocolate bar at 0.85")      
          purchase.line_item_tax.should == 0.0
        end
     
        it "should know it has only domestic tax and what that tax is" do
          purchase =  LineItem.new("1 music CD at 14.99")      
          purchase.line_item_tax.should == 1.50
        end
        
        it "should know it has an only import tax and what that tax is" do
          purchase =  LineItem.new("1 imported bottle of perfume at 27.99")      
          purchase.line_item_tax.should == 4.20
        end
        
        it "should know it has an import with no domestic taxes and what those taxes are" do
          purchase =  LineItem.new("1 box of imported chocolates at 11.25")      
          purchase.line_item_tax.should be_close(0.60, 0.005)
        end
      end
    end  # End of Calculate taxes for a line item
          
      describe "Calculate line item costs" do
    
        context "a line item with a quanity of 1 is cost + relevant tax" do
    
          it "should know the total for 1 domestic tax free item" do
            purchase =  LineItem.new("1 packet of headache pills at 9.75")      
            purchase.line_item_total.should == 9.75
          end
    
          it "should know the total for 1 domestic taxable item" do
            purchase =  LineItem.new("1 music CD at 14.99")      
            purchase.line_item_total.should be_close(16.49, 0.005)
          end
    
          it "should know the total for 1 imported taxable item" do
            purchase =  LineItem.new("1 imported bottle of perfume at 27.99")      
            purchase.line_item_total.should == 32.19
          end
    
          it "should know the total for 1 imported non taxable item" do
            purchase =  LineItem.new("1 box of imported chocolates at 11.25")      
            purchase.line_item_total.should be_close(11.85, 0.005)
          end
        end
        
        context "a line item with a quanity of > 1 = cost + relevant tax multiplied by quanity" do
          # TODO - Clarify with customer that the assumptions underlying theses tests are correct
          #        (e.g. the maner in which tax is calculated for quantities maximizes potential
          #         tax revenue due to rounding, but may not be what legistature called for - note 
          #         business rules for taxes, like many business rules, aren't especially logical 
          #         and shouldn't be guessed) - Also get several examples from customer
          #         NOTE: Can't do with with an on-line coding exercise - need real customer rep
    
          it "should know the total for 2 domestic tax free items" do
            purchase =  LineItem.new("2 packet of headache pills at 9.75")      
            purchase.line_item_total.should be_close(19.50, 0.005)
          end
          
          it "should know the total for 3 domestic taxable items" do
            purchase =  LineItem.new("3 music CDs at 14.99")      
            purchase.line_item_total.should be_close(49.47, 0.005)
          end
          
          it "should know the total for 4 imported taxable items" do
            purchase =  LineItem.new("4 imported bottles of perfume at 27.99")     
            purchase.line_item_total.should be_close(128.76, 0.005)
          end
          
          it "should know the total for 100 imported non taxable item" do
            purchase =  LineItem.new("100 boxes of imported chocolates at 11.25")      
            purchase.line_item_total.should be_close(1185.00, 0.005)
          end
        end
    
    end  # End of Calculate line item costs

  end # End of LineItem Describe

end  # End of Module