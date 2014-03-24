require 'spec_helper'

module Shopping
  
  describe PrintableReceipt do
    let(:output)        {double('output').as_null_object}
    let(:new_receipt)   {Receipt.new}
    
    describe "Build printable version of receipt" do
    
      context "Individual input lines builds individual output line item lines that don't need transposing" do
        
        it "should print book line correctly" do
          new_receipt.add_line_item(LineItem.new("1 book at 12.49"))
          new_printable = PrintableReceipt.new(new_receipt, output)
          new_printable.first.should include("1 book: 12.49")
        end
        
        it "should print imported chocolates line correctly" do
          new_receipt.add_line_item(LineItem.new("1 imported bottle of perfume at 47.50"))
          new_printable = PrintableReceipt.new(new_receipt, output)
          new_printable.first.should include("1 imported bottle of perfume: 54.65")
        end       
      end      
 
      context "Individual input lines builds individual output line item lines that DO need transposing" do
        
        it "should print imported chocolates line correctly" do
          new_receipt.add_line_item(LineItem.new("1 box of imported chocolates at 11.25"))
          new_printable = PrintableReceipt.new(new_receipt, output)
          new_printable.first.should include("1 imported box of chocolates: 11.85")
        end
        
      end
      
      context "Multiple input lines builds individual output line item lines, tax and total lines" do
        before(:each) do
          new_receipt.add_line_item(LineItem.new("1 book at 12.49"))
          new_receipt.add_line_item(LineItem.new("1 music CD at 14.99"))
          new_receipt.add_line_item(LineItem.new("1 chocolate bar at 0.85"))
          @new_printable = PrintableReceipt.new(new_receipt, output)         
        end
      
        it "should print the first line item line correctly" do
          @new_printable.index(0).should include("1 book: 12.49")
        end
        
        it "should print the second line item line correctly" do
          @new_printable.index(1).should include("1 music CD: 16.49")
        end
        
        it "should print the third line item line correctly" do
          @new_printable.index(2).should include("1 chocolate bar: 0.85")
        end

        it "should print the 4th tax line line correctly" do
          @new_printable.index(3).should include("Sales Taxes: 1.50")
        end

        it "should print the 5th total line line correctly" do
          @new_printable.index(4).should include("Total: 29.83")
        end      
      end
    end  # End of Build printable version of receipt
        
    describe "Display receipt to customer" do
      
      context "Sample Output 1:" do         
        before(:each) do
          new_receipt.add_line_item(LineItem.new("1 book at 12.49"))
          new_receipt.add_line_item(LineItem.new("1 music CD at 14.99"))
          new_receipt.add_line_item(LineItem.new("1 chocolate bar at 0.85"))    
          @new_printable = PrintableReceipt.new(new_receipt, output)         
        end
      
        it "should display the first line of the receipt" do
          output.should_receive(:puts).with("1 book: 12.49")    
          @new_printable.print_receipt
        end
      
        it "should display the first line of the receipt" do
           output.should_receive(:puts).with("1 music CD: 16.49")    
           @new_printable.print_receipt
         end
           
        it "should display the first line of the receipt" do
          output.should_receive(:puts).with("1 chocolate bar: 0.85")    
          @new_printable.print_receipt
        end
           
        it "should display the tax line of the receipt" do
          output.should_receive(:puts).with("Sales Taxes: 1.50")    
          @new_printable.print_receipt
        end
           
        it "should display the total line of the receipt" do
          output.should_receive(:puts).with("Total: 29.83")    
          @new_printable.print_receipt
        end      
      end
      
      context "Sample Output 2:" do         
        before(:each) do
          new_receipt.add_line_item(LineItem.new("1 imported box of chocolates at 10.00"))
          new_receipt.add_line_item(LineItem.new("1 imported bottle of perfume at 47.50"))   
          @new_printable = PrintableReceipt.new(new_receipt, output)         
        end
      
        it "should display the first line of the receipt" do
          output.should_receive(:puts).with("1 imported box of chocolates: 10.50")    
          @new_printable.print_receipt
        end

        it "should display the first line of the receipt" do
           output.should_receive(:puts).with("1 imported bottle of perfume: 54.65")    
           @new_printable.print_receipt
        end
         
        it "should display the tax line of the receipt" do
          output.should_receive(:puts).with("Sales Taxes: 7.65")    
          @new_printable.print_receipt
        end
           
        it "should display the total line of the receipt" do
          output.should_receive(:puts).with("Total: 65.15")    
          @new_printable.print_receipt
        end      
      end
      
      context "Sample Output 3:" do         
        before(:each) do
          new_receipt.add_line_item(LineItem.new("1 imported bottle of perfume at 27.99"))
          new_receipt.add_line_item(LineItem.new("1 bottle of perfume at 18.99"))
          new_receipt.add_line_item(LineItem.new("1 packet of headache pills at 9.75"))
          new_receipt.add_line_item(LineItem.new("1 box of imported chocolates at 11.25"))      
          @new_printable = PrintableReceipt.new(new_receipt, output)         
        end
      
        it "should display the first line of the receipt" do
          output.should_receive(:puts).with("1 imported bottle of perfume: 32.19")    
          @new_printable.print_receipt
        end

        it "should display the first line of the receipt" do
           output.should_receive(:puts).with("1 packet of headache pills: 9.75")    
           @new_printable.print_receipt
         end
           
        it "should display the first line of the receipt" do
          output.should_receive(:puts).with("1 bottle of perfume: 20.89")    
          @new_printable.print_receipt
        end
           
        it "should display the first line of the receipt" do
          output.should_receive(:puts).with("1 imported box of chocolates: 11.85")    
          @new_printable.print_receipt
        end      

        it "should display the tax line of the receipt" do
          output.should_receive(:puts).with("Sales Taxes: 6.70")    
          @new_printable.print_receipt
        end
           
        it "should display the total line of the receipt" do
          output.should_receive(:puts).with("Total: 74.68")    
          @new_printable.print_receipt
        end      
      end
    end # End of Display receipt to customer

  end # End of PrintableReceipt Describe

end  # End of Module
