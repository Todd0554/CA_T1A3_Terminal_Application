require_relative '../product_list'
require_relative '../code_music'
require_relative '../order'
require_relative '../module_service'

describe Service do # moudle Service: test of pay_by_cash method
    it 'should caculate the change if customers want to use cash.' do
        class A
            include Service
        end
        test_changes = A.new
        expect(test_changes.pay_by_cash(10, 20)).to be(puts "Please check your changes, 10 dollar.")
    end
end

describe Order do # class Order: test of show_price_list method
    it 'should show the name and the price of each product.' do
        guitar = {"tele": 1600, 
                  "gibson": 2300}
        guitar_list = Order.new
        a = guitar.each do |product, price|
            puts "#{product}: $#{price}"end
        expect(guitar_list.show_price_list(guitar)).to be(a)
    end
end