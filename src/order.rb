class Order
    
    def show_price_list(hash_of_list)
        hash_of_list.each do |product, price|
            puts "#{product}: $#{price}"
        end
    end
    
    def price_caculator(price_of_item)
        total_price =price_of_item
    end


end


