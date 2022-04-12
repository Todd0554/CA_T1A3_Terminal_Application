require './module_service'

class Order
    attr_reader :price_of_item
    include Service
    def initialize(price_of_item = 0)
        @price_of_item = price_of_item
    end

    def show_price_list(hash_of_product)
        hash_of_product.each do |product, price|
            puts "#{product}: $#{price}"
        end
    end
    
    def get_price(hash_of_product, name_of_item)
        @price_of_item = hash_of_product[name_of_item.to_sym].to_f
    end
end










