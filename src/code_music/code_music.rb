require './product_list'
require './order'
require './module_service'
require 'colorize'
require 'tty-table'


class CodeMusic < Order # CodeMusic class inherits from class Order
    
    def initialize(final_money = 0)  
        @final_money = final_money
    end

    def discount_for_CA_student(total_price) # This is the method to give a discount if the customer is CA students
        @final_money += total_price * 0.8 
    end

    def shopping_in_CodeMusic # This is the method of main progress of shopping
        puts ProductList::LOGO # show the LOGO of Code Music
        welcome("Code Music".colorize(:blue)) # say hi to customers
        total_price = 0 # set an initial total price
        shopping = true # set a boolean to control whether the shopping continue
        while shopping == true # when shopping is true, the programme will continue 
            puts (ProductList::LISTTABLE).render(:ascii).colorize(:blue) # show the table of product list by using tty-table
            puts "What kind of " + "music instruments".colorize(:green) + " do you want to buy, " + "guitar".colorize(:yellow) + ", " + "amplifier".colorize(:yellow) + " or " + "pedal".colorize(:yellow) + "?"# ask what kind of products customer wanna buy
            music_instrument_type = gets.chomp.downcase # get the reply into string
            
                begin # use exception handling
                    type = ProductList::LIST[music_instrument_type.to_sym]
                    show_price_list(type)
                rescue NoMethodError
                    puts "Please insert guitar, amplifier or pedal.".colorize(:red) # if customer did not insert correct words of 'guitar', 'amplifier' and 'pedal', puts this to tell customer they insert wrong word
                end
        
            if ProductList::LIST.has_key?(music_instrument_type.to_sym) # if customer insert the word of 'guitar', 'amplifier' and 'pedal'
                puts "Which one do you want?" # ask customer which product they wanna buy
                product_chosen_by_customer = gets.chomp.downcase
                
                if !type.has_key?(product_chosen_by_customer.to_sym) # if customer did not insert correct word
                    puts "Please insert correct name of the product.".colorize(:red)
                else # if customer insert correct name of product
                    puts "The #{product_chosen_by_customer.colorize(:red)} is #{get_price(type, product_chosen_by_customer.to_sym).to_s.colorize(:red)} dollars." # show customer price again
                    total_price += get_price(type, product_chosen_by_customer).to_f # add the price to total price
                    puts "Do you want to buy other products? y/n" # and then ask customer whether they wanna buy other products
                    continue_to_buy = gets.chomp
                    while continue_to_buy != 'y' && continue_to_buy != 'n' # if customer did nt insert 'y' or 'n'
                        puts "Please answer in 'y' or 'n'".colorize(:red) # tell customer use 'y' or 'n' to answer
                        puts "Do you want to buy other products? y/n"
                        continue_to_buy = gets.chomp
                    end
                    shopping = true if continue_to_buy == "y" # if customer answer 'y', shopping will be true which means the shopping will continue. This loop will start again
                    shopping = false if continue_to_buy == "n" # if 'n', shopping will stop
                end
            end
        end
        
        puts "Totally #{total_price.to_s.colorize(:red)} dollar, are you a student of Code Academy? y/n" if shopping == false # then the total money will be calculated and ask the customer whether he or she is a student of CA
        student_of_CA = gets.chomp

        while student_of_CA != "y" && student_of_CA != "n" # if customer did not answer in 'y' or 'n'
            puts "Please answer in 'y' or 'n'".colorize(:red) #tell customer use 'y' or 'n' to answer
            puts "Totally #{total_price.to_s.colorize(:red)} dollar, are you a student of Code Academy? y/n" # ask again
            student_of_CA = gets.chomp
        end



        if student_of_CA == "y" # if customer is CA student
            discount_for_CA_student(total_price) # give a discount on total price
        elsif student_of_CA == "n" # if customer is not CA student
            @final_money += total_price # there is no change on total price
        end
        puts "Thank you, the totally price is #{@final_money.round(2).to_s.colorize(:red)}, cash or card?" # tell customer the final total price after discount and then ask customer how to pay
        how_to_pay = gets.chomp.downcase # transform into lowercase

        while how_to_pay != "cash" && how_to_pay != "card" # if customer did not use 'cash' or 'card' to answer
            puts "Please answer in 'cash' or 'card'".colorize(:red) # tell customer
            puts "Cash or card?" # ask again
            how_to_pay = gets.chomp.downcase
        end

        if how_to_pay == "card" # if customer use card
            pay_by_card()  # call pay_by_card
        elsif how_to_pay == "cash" # if customer use cash
            puts "Please insert money. (insert a number)".colorize(:green) # ask customer to insert money
             
            money_customer_paid = gets.chomp.to_f
                while money_customer_paid < @final_money # if the money inserted is not enough
                    puts "Sorry, the money is not enough, please insert more money.".colorize(:red) # tell customer it is not enough
                    puts "How much money do you want to insert?".colorize(:yellow) # ask customer to insert more money
                    money_customer_paid += gets.chomp.to_f # save the money the customer insert until the money is enough
                end
                pay_by_cash(@final_money, money_customer_paid) # calculate changes
        end
        goodbye() # say goodbye to customer
    end
end

shopping = CodeMusic.new
shopping.shopping_in_CodeMusic