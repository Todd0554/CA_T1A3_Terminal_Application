require './product_list'
require './order'
require './module_service'
require 'colorize'

class CodeMusic < Order # CodeMusic class inherits from class Order
   
    def initialize(final_money = 0)  
        @final_money = final_money
    end

    def discount_for_CA_student(total_price) # This is the method to give a discount if the customer is CA students
        @final_money += total_price * 0.8 
    end

    def shopping_in_CodeMusic
        puts ProductList::LOGO
        welcome("Code Music".colorize(:blue)) # say hi to customers
        total_price = 0 # set an initial total price
        shopping = true # set a boolean to control whether the shopping continue
        while shopping == true 
            puts "What kind of " + "music instruments".colorize(:green) + " do you want to buy, " + "guitar".colorize(:yellow) + ", " + "amplifier".colorize(:yellow) + " or " + "pedal".colorize(:yellow) + "?"
            music_instrument_type = gets.chomp
            
                begin
                    type = ProductList::LIST[music_instrument_type.to_sym]
                    show_price_list(type)
                rescue NoMethodError
                    puts "Please insert guitar, amplifier or pedal.".colorize(:red)
                end
        
            if ProductList::LIST.has_key?(music_instrument_type.to_sym)
                puts "Which one do you want?"
                product_chosen_by_customer = gets.chomp
                
                if !type.has_key?(product_chosen_by_customer.to_sym)
                    puts "Please insert correct name of the product.".colorize(:red)
                else
                    puts "The #{product_chosen_by_customer.colorize(:red)} is #{get_price(type, product_chosen_by_customer.to_sym).to_s.colorize(:red)} dollars."
                    total_price += get_price(type, product_chosen_by_customer).to_f
                    puts "Do you want to buy other products? y/n"
                    continue_to_buy = gets.chomp
                    while continue_to_buy != 'y' && continue_to_buy != 'n'
                        puts "Please answer in 'y' or 'n'".colorize(:red)
                        puts "Do you want to buy other products? y/n"
                        continue_to_buy = gets.chomp
                    end
                    shopping = true if continue_to_buy == "y"
                    shopping = false if continue_to_buy == "n"
                end
            end
        end
        
        puts "Totally #{total_price.to_s.colorize(:red)} dollar, are you a student of Code Academy? y/n" if shopping == false
        student_of_CA = gets.chomp

        while student_of_CA != "y" && student_of_CA != "n"
            puts "Please answer in 'y' or 'n'".colorize(:red)
            puts "Totally #{total_price.to_s.colorize(:red)} dollar, are you a student of Code Academy? y/n"
            student_of_CA = gets.chomp
        end
        if student_of_CA == "y"
            discount_for_CA_student(total_price)
        elsif student_of_CA == "n"
            @final_money += total_price
        end
        puts "Thank you, the totally price is #{@final_money.round(2).to_s.colorize(:red)}, cash or card?" 
        how_to_pay = gets.chomp.downcase

        while how_to_pay != "cash" && how_to_pay != "card"
            puts "Please answer in 'cash' or 'card'".colorize(:red)
            puts "Cash or card?"
            how_to_pay = gets.chomp.downcase
        end

        if how_to_pay == "card"
            pay_by_card  
        elsif how_to_pay == "cash"
            puts "Please insert money. (insert a number)".colorize(:green)
             
            money_customer_paid = gets.chomp.to_f
                while money_customer_paid < @final_money
                    puts "Sorry, the money is not enough, please insert more money.".colorize(:red)
                    puts "How much money do you want to insert?".colorize(:yellow)
                    money_customer_paid += gets.chomp.to_f
                end
                pay_by_cash(@final_money, money_customer_paid)
        end
        goodbye()
    end
end

todd = CodeMusic.new
todd.shopping_in_CodeMusic