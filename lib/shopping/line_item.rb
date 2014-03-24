module Shopping
  
  class LineItem    
    
    def initialize(input)
      @name     = ''
      @quantity = 0
      @price    = 0.0
      @import_taxable = false
      @free_of_domestic_tax = true
      @line_item_tax = 99999.99
      @line_item_total = 0.0
      determine_name_quanity_and_price(input)
      determine_tax_info
      determine_line_item_total
    end
    
    def name
      @name
    end
    
    def quantity
      @quantity
    end
 
    def price
      @price
    end
 
    def import_taxable
      @import_taxable
    end

    def free_of_domestic_tax
      @free_of_domestic_tax
    end

    def line_item_tax
      @line_item_tax
    end
    
    def line_item_total
      @line_item_total
    end
    
    private
      def determine_name_quanity_and_price(line_item_input_string_to_parse)
        tokens = line_item_input_string_to_parse.split(' ')
        @quantity = tokens.first.to_i
        tokens.slice!(0)
        @price    = tokens.last.to_f
        tokens.slice!(tokens.size-2,tokens.size-1)
        @name     = tokens.join(' ')       
      end
    
      def determine_tax_info
        tax_engine = Taxes.new
        @import_taxable = tax_engine.is_imported?(@name)
        @free_of_domestic_tax = tax_engine.is_tax_exempt?(@name)
        @line_item_tax = tax_engine.rounded_tax(@import_taxable, @free_of_domestic_tax, @price)
      end
      
      def determine_line_item_total
        # TODO - Clarify simple calcuation correctness woith customer - see rspec notes
        @line_item_total = @quantity * (@price + @line_item_tax)
      end        
  end

end