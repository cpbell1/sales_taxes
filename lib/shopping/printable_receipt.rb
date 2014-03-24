module Shopping
  
  class PrintableReceipt
    
    def initialize(receipt, output)
      @printable = []
      @output = output
      load_printable_line_items(receipt)
      load_tax_line(receipt)
      load_total_line(receipt)
    end

    def first
      @printable.first
    end
    
    def index(x)
      @printable[x]
    end
    
    def print_receipt
      @printable.each do |receipt_line| 
        @output.puts receipt_line
      end      
    end

    private
    def load_printable_line_items(receipt)
      # TODO - Clarify formated output rules with customer
      #      - Assumed that placement of upfront placement of 'imported' was deliberate
      #      - and that space between 'book' and ':' was typo
      for i in 0..(receipt.size- 1 )
        line_item = receipt.index(i)
        # Support implied business rule that "imported" must be first word in output
        new_name = line_item.name
        if line_item.name.include?("imported")
          new_name = line_item.name
          new_name["imported "] = ""
          new_name.insert(0, "imported ")
        end
        @printable[i] = line_item.quantity.to_s + ' ' + new_name + ': ' + add_zeros_as_needed(line_item.line_item_total)
      end
    end
   
    def load_tax_line(receipt)
      if receipt.size > 0
        @printable << "Sales Taxes: " + add_zeros_as_needed(receipt.total_sales_tax)
      end
    end

    def load_total_line(receipt)
      if receipt.size > 0      
        @printable << "Total: " + add_zeros_as_needed(receipt.total)
      end
    end
   
    def add_zeros_as_needed(float_input)
      formated_string = float_input.to_s
      position_of_decimal_point = formated_string.index('.')
      if position_of_decimal_point > (formated_string.length - 3)
        formated_string += "0"
      end
      formated_string
    end
    
  end # End of class
  
end # Endof module 