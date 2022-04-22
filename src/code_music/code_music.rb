require './product_list'
require './order'
require './module_service'
require 'colorize'
require 'tty-table'
require "tty-prompt"


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
        prompt = TTY::Prompt.new
        
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
                a = []
                type.each_key{|key| a << key.to_s}
                product_chosen_by_customer = (prompt.select("Which one do you want?", a)).to_s
                puts "The #{product_chosen_by_customer.colorize(:red)} is #{get_price(type, product_chosen_by_customer.to_sym).to_s.colorize(:red)} dollars." # show customer price again
                total_price += get_price(type, product_chosen_by_customer).to_f # add the price to total price
                    
                shopping = prompt.yes?("Do you want to buy other products?")
            end
        end
        student_of_CA = prompt.yes?("Totally #{total_price.to_s.colorize(:red)} dollar, are you a student of Code Academy?") # then the total money will be calculated and ask the customer whether he or she is a student of CA
        
        if student_of_CA # if customer is CA student
            discount_for_CA_student(total_price) # give a discount on total price
        elsif !student_of_CA # if customer is not CA student
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
            money_customer_paid = prompt.ask("Please insert money. (insert a number)".colorize(:green), convert: :float) do |q| # ask customer to insert money
                                      q.convert(:float, "Wrong value of %{value} for %{type} conversion")
                                      q.convert :float
                                      q.messages[:convert?] = "Wrong value of %{value} for %{type} conversion"
                                  end
             
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

