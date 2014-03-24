module Shopping
  
  class Receipt
    
   def initialize
      @basket = []
      @tax = 0.0
      @total_cost = 0.0
    end
    
    def size
      @basket.size
    end
    
    def add_line_item(a_line_item)
      @basket << a_line_item
      calculate_total_sales_tax
      calculate_total
    end
    
    def first
      @basket.first
    end
    
    def last
      @basket.last
    end

    def index(x)
      @basket[x]
    end

    def total_sales_tax
     @tax
    end
    
    def total
      @total_cost
    end
    
    private
    
    def calculate_total_sales_tax
      @tax = 0.0
      @basket.each do |x|
        @tax += x.line_item_tax
      end
    end
    
    def calculate_total
      @total_cost = 0.0
      @basket.each do |x|
         @total_cost += x.price
      end
      @total_cost += total_sales_tax       
    end   
    
  end
  
end
