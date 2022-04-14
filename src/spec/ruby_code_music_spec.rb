require_relative '../product_list'
require_relative '../code_music'
require_relative '../order'
require_relative '../module_service'

describe Service do 
    it 'should caculate the change if customers want to use cash.' do # moudle Service: test of pay_by_cash method
        class A
            include Service
        end
        test_changes = A.new
        expect(test_changes.pay_by_cash(10, 20)).to be(puts "Please check your changes, 10 dollar.")
    end
end

describe Order do 
    it 'should show the name and the price of each product.' do # class Order: test of show_price_list method
        guitar = {"tele": 1600, 
                  "gibson sg": 2336}
        guitar_list = Order.new
        a = guitar.each do |product, price|
            puts "#{product}: $#{price}"end
        expect(guitar_list.show_price_list(guitar)).to be(a)
    end

    it 'should give the price of the item in float.' do # class Order: test of get_price method
        a = Order.new
        a.get_price({"tele": 1600, 
            "gibson": 2336, 
            "stra": 1443, 
            "maton": 1899}, "tele")
        expect(a.price_of_item).to eq(1600.0)
    end
end

describe CodeMusic do
    it 'should give 80 percent of discount for CA students.' do
        test_money = CodeMusic.new
        expect(test_money.discount_for_CA_student(1000)).to eq(800)
    end
end
