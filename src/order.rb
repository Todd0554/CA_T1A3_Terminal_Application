require './module_service'
require 'colorize'

class Order #order class which provide basic methods including show_price_list and get_price)
    attr_reader :price_of_item
    include Service # class Order includes Service module
    def initialize(price_of_item = 0)
        @price_of_item = price_of_item
    end

    def show_price_list(hash_of_product) # show customer the list of the products they wanna buy
        
        hash_of_product.each do |product, price|
            puts "#{product}".colorize(:yellow) + ": " + "$".colorize(:red) + "#{price}".colorize(:green)
        end
    end
    
    def get_price(hash_of_product, name_of_item) # to get the price of the product the customer choose to buy
        @price_of_item = hash_of_product[name_of_item.to_sym].to_f
    end
end
