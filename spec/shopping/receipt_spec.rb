require 'spec_helper'

module Shopping
  
  describe Receipt do

    let(:new_receipt)   {Receipt.new}    
    describe "knows what it stored" do
                
     it "should retrieve what it just stored" do
        new_receipt.add_line_item(LineItem.new("1 book at 12.49"))
        line_item = new_receipt.first
        line_item.name.should == "book"
      end

      it "should retrieve the the first item it stored after adding 2" do
        first_item = LineItem.new("1 music CD at 14.99")
        new_receipt.add_line_item(first_item )
        second_item = LineItem.new("1 chocolate bar at 0.85")
        new_receipt.add_line_item(second_item)
        new_receipt.first.name.should == "music CD"
        new_receipt.first.line_item_tax.should == 1.50
       end
 
      
      it "should retrieve the first and last item it stored" do
        new_receipt.add_line_item(LineItem.new("1 book at 12.49"))
        new_receipt.add_line_item(LineItem.new("1 music CD at 14.99"))
        new_receipt.add_line_item(LineItem.new("1 chocolate bar at 0.85"))
        new_receipt.first.name.should == "book"
        new_receipt.index(1).name     == "music CD"
        new_receipt.last.name.should  == "chocolate bar"
      end          
    end  # End of knows what it just stored


    describe "holds many line items" do
          
      it "should know how many line items it has on creation" do        
        new_receipt.size.should == 0
      end
      
      it "should know how many line items it has after adding 1" do
        new_receipt.add_line_item(LineItem.new("1 chocolate bar at 0.85"))
        new_receipt.size.should == 1
      end

      it "should know how many line items it has after adding 2" do
        new_receipt.add_line_item(LineItem.new("1 music CD at 14.99"))
        new_receipt.add_line_item(LineItem.new("1 chocolate bar at 0.85"))
        new_receipt.size.should == 2
      end
      
      it "should know how many line items it has after adding 3" do
        new_receipt.add_line_item(LineItem.new("1 book at 12.49"))
        new_receipt.add_line_item(LineItem.new("1 music CD at 14.99"))
        new_receipt.add_line_item(LineItem.new("1 chocolate bar at 0.85"))
        new_receipt.size.should == 3
      end   
    
    end  # End of holds many line items

    describe "Knows total sales tax and final total for receipt" do  
      
      it "should know the total tax" do
        new_receipt.add_line_item(LineItem.new("1 book at 12.49"))
        new_receipt.add_line_item(LineItem.new("1 music CD at 14.99"))
        new_receipt.add_line_item(LineItem.new("1 chocolate bar at 0.85"))
        new_receipt.total_sales_tax.should == 1.50
      end   
 
      it "should know the final total" do
        new_receipt.add_line_item(LineItem.new("1 book at 12.49"))
        new_receipt.add_line_item(LineItem.new("1 music CD at 14.99"))
        new_receipt.add_line_item(LineItem.new("1 chocolate bar at 0.85"))
        new_receipt.total.should be_close(29.83, 0.005)
      end   
       
    end  # End of Knows total sales tax and final total for receipt

  end # End of Receipt Describe

end  # End of Module