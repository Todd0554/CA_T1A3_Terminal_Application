require './product_list'
require './order'
require './module_service'


class CodeMusic < Order
   
    def initialize(final_money = 0)
        @final_money = final_money
    end

    def discount_for_CA_student(total_price)
        @final_money += total_price * 0.8
    end

    def shopping_in_CodeMusic
        welcome("Code Music")
        total_price = 0
        shopping = true
        while shopping == true 
            puts "What kind of music instruments do you want to buy, guitar, amplifier or pedal?"
            music_instrument_type = gets.chomp
            type = ProductList::LIST[music_instrument_type.to_sym]
            show_price_list(type)
            puts "Which one do you want?"
            product_chosen_by_customer = gets.chomp
            puts "The #{product_chosen_by_customer} is #{get_price(type, product_chosen_by_customer.to_sym)} dollars."
            total_price += get_price(type, product_chosen_by_customer).to_f
            puts "Do you want to buy other products? Please insert 'y' or 'n'"
            continue_to_buy = gets.chomp
            case continue_to_buy
            when "y"
                shopping = true
            when "n"
                shopping = false
            end
        end
        
        puts "Totally #{total_price} dollar, are you a student of Code Academy? y/n" if shopping == false
        if gets.chomp == "y"
            discount_for_CA_student(total_price)
        elsif gets.chomp == "n"
            @final_money += total_price
        end
        puts "Thank you, the totally price is #{@final_money.round(2)}, cash or card?" 
        how_to_pay = gets.chomp
        
        if how_to_pay == "card"
            pay_by_card  
        elsif how_to_pay == "cash"
            puts "Please insert money. (insert a number)"
            money_customer_paid = gets.chomp.to_f
            while money_customer_paid < @final_money
                puts "Sorry, the money is not enough, please insert more money."
                puts "How much money do you want to insert?"
                money_customer_paid += gets.chomp.to_f
            end
            pay_by_cash(@final_money, money_customer_paid)
        end
        goodbye()
    end

end





