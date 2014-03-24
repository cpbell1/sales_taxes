module Shopping
  
  class Taxes
    
    def initialize
      @import_rate = 0.05
      @base_rate   = 0.10      
    end
    
    def to_nearest_five_cents_rounded_up (amount)
     rounded = (((amount *100) / 5.0).round * 5) / 100.0
     if amount > rounded 
       rounded += 0.05
     end
     rounded
    end
    
    def tax_rate(imported, tax_exempt)
      
      tax_rate = 0.0
               
      if imported
         tax_rate += @import_rate
       end
           
       if !tax_exempt
         tax_rate += @base_rate
       end
             
       tax_rate    
    end
    
    def is_imported?(product_string)
      product_string.include?("imported")
    end
    
    # TODO - Refactor for greater flexibility
    # Use list of keywords
    # Write method to load keywords
    # Then each through all keywords
    def is_tax_exempt?(product_string)
      product_string.include?("book") || product_string.include?("chocolate") || product_string.include?("pills") 
    end
    
    def rounded_tax(imported, tax_free, price)
      unrounded_tax = tax_rate(imported, tax_free) * price
      to_nearest_five_cents_rounded_up(unrounded_tax)
    end
    
  end
  
end
