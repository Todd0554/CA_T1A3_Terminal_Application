# Introduction  
#### ***Code Music*** is an terminal  application which can provide basic shopping service of selling music instruments.  
***
# Github Repository  

#### https://github.com/Todd0554/CA_T1A3_Terminal_Application  
***

# How to use
#### This application is based on ruby, so ruby needs to be installed to your computer. In addition, you also need to install bundler, ruby gem of tty-table, colorize and rspec.  

#### After downloading or cloning the app from github, you need to open your terminal go into *'src/code_music'* folder. Then, using the code below to run the programme directly. 
```
   ./code_music.rb
```
#### Now, you are in CodeMusic! Welcome!
![Exceptional Handling](/docs/Screen%20Shot%202022-04-22%20at%2011.21.55.png)  
#### The programme will ask you to choose a type of music instrument you wanna buy.  
```
   What kind of music instruments do you want to buy, guitar, amplifier or pedal?
```
#### You can type anything here, but if the programme can't understand you which means you did not insert valid answer(here is guitar, amplifier or pedal), the programme will give you a hint and the table will show again.
```
Please insert guitar, amplifier or pedal.
+---------------+--------------+--------------+
|Guitar         |Amplifier     |Pedal         |
+---------------+--------------+--------------+
|tele: 1600     |fishman: 650  |overdrive: 216|
|gibson sg: 2336|marshall: 989 |reverb: 158   |
|stra: 1443     |blackstar: 455|delay: 188    |
|maton: 1899    |mesa: 999     |looper: 466   |
+---------------+--------------+--------------+
What kind of music instruments do you want to buy, guitar, amplifier or pedal?
```
#### After you insert a valid word, the programme will show you all the products of this type and ask "which one do you wanna buy?".
```
What kind of music instruments do you want to buy, guitar, amplifier or pedal?
guitar
tele: $1600
gibson sg: $2336
stra: $1443
maton: $1899
Which one do you want?
```
#### Here is same as before, you need to insert valid name of the product. Then, the programme will show the price of the product you choose to buy and ask you whether you want to contiunue.  
```
Which one do you want?
tele
The tele is 1600.0 dollars.
Do you want to buy other products? y/n
```
#### You need to type y or n, otherwise the programme can't understand you. if you choose y, the shopping process will start again. However, if you choose n, the programme will show the total price and ask you whether you are a student of CA. If you are, there will be a discount on your payment.  
```
Do you want to buy other products? y/n
n
Totally 1600.0 dollar, are you a student of Code Academy? y/n
y
Thank you, the totally price is 1280.0, cash or card?
```
#### Then, the programme will ask you the method of payment. If you choose paying by card, everything gonna easy, just taping the card. However, if you choose cash, the programme will let you insert money in a number. If you insert words not valid and can't be understood by the programme, it will ask again. on the other hand, if the money you insert is not enough, the programme will save it and let you insert more money until the total money you insert is greater than or equal to the money you need to pay. Finally, the changes will be calculated. 
```
Thank you, the totally price is 1280.0, cash or card?
cash
Please insert money. (insert a number)
900
Sorry, the money is not enough, please insert more money.
How much money do you want to insert?
122
Sorry, the money is not enough, please insert more money.
How much money do you want to insert?
233
Sorry, the money is not enough, please insert more money.
How much money do you want to insert?
444
Please check your changes, 419.0 dollar.
Thank you for your coming and have a good day.
```
# Project Mnagement
#### I use Trello to manage this project. The project is seperated into 4 parts including code, PPT, Git and README.md. Code and Git are implemented together. PPT is planned before the presentation day. When the code part was almost done, the README.md started.  
#### The code part is seperated by the rb. files. When a file is finished, the tag of this file will be moved under finish. 
![Exceptional Handling](/docs/Screen%20Shot%202022-04-18%20at%2009.29.07.png)  

# Documentation  

## 1. 'docs' Folder  

#### This folder cotains the screenshots used in markdown documentation.  

## 2. 'ppt' Folder  

#### This folder contains the ppt for presentation.  

## 3. 'README.md' File  

#### This markdown file provides an overview and instruction of the programme.  

## 4. 'src' Folder  

#### This folder contains codes in different rb. files.  

1. ***'bin', 'spec', 'Gemfile' and 'Gemfile.lock'***  
   These folders and files provide ruby gem for this programme, including Rspec, colorize and tty-table.  
2. ***'code_music.rb'***  
   This .rb file is the main programme of this terminal application. There is a class of ***CodeMusic*** inside and in this class, the method of ***'shopping_in_CodeMusic'*** contains complete process of shopping. Please refer to the notes for specific process. The codes with notes are shown below.  
```ruby
    #!/usr/bin/env ruby
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
    # xinzhe = CodeMusic.new
    # xinzhe.shopping_in_CodeMusic
```
3. ***'module_service.rb'***
   This .rb file contains a module called *'Service'*. This module has several methods which are basic methods for a shop. These methods can not only be used by CodeMusic, but also other shops, stores or supermarkets. The codes are shown below.
```ruby
    require 'colorize'

    module Service  #basic shop service processes are here. Other stores also can use them. 
        def welcome (store_name) # welcome to customer
            puts "Welcome to #{store_name}."
        end

        def pay_by_card
            puts "Please tap here."
        end

        def pay_by_cash(money_need_to_be_paid, money_customer_paid) # calculate changes
            changes = money_customer_paid - money_need_to_be_paid
            puts "Please check your changes, " + "#{changes.round(2)}".colorize(:red) + " dollar."
        end

        def goodbye # say goodbye to customer
            puts "Thank you for your coming and have a good day."
        end
    end
```
4. ***'order.rb'***  
   This .rb file contains a class of *'Order'*, which provides order methods including ***'show_price_list'*** and ***'get_price'*** for CodeMusic. The codes are shown below.  
```ruby
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
```
5. ***'product_list.rb'***  
   This .rb file contains another module called *'ProductList'*, and this module provides the logo of the terminal application, list of products and price and the table of the products. The codes are shown below.  
```ruby
    require 'colorize'
    require 'tty-table'

    module ProductList 
        # product list
        LIST = {"guitar": {"tele": 1600, 
                        "gibson sg": 2336, 
                        "stra": 1443, 
                        "maton": 1899},
                "amplifier": {"fishman": 650, 
                            "marshall": 989, 
                            "blackstar": 455,
                            "mesa": 999},
                "pedal": {"overdrive": 216, 
                        "reverb": 158, 
                        "delay": 188, 
                        "looper": 466}}
        # table established by tty-table
        LISTTABLE = TTY::Table.new(["Guitar", "Amplifier", "Pedal"], [["tele: 1600", "fishman: 650", "overdrive: 216"], ["gibson sg: 2336","marshall: 989", "reverb: 158"], ["stra: 1443", "blackstar: 455", "delay: 188"], ["maton: 1899","mesa: 999", "looper: 466"]])
        # code music LOGO
        LOGO = [' 
            $$$$$$\                  $$\                 $$\      $$\                     $$\           
            $$  __$$\                 $$ |                $$$\    $$$ |                    \__|          
            $$ /  \__| $$$$$$\   $$$$$$$ | $$$$$$\        $$$$\  $$$$ |$$\   $$\  $$$$$$$\ $$\  $$$$$$$\ 
            $$ |      $$  __$$\ $$  __$$ |$$  __$$\       $$\$$\$$ $$ |$$ |  $$ |$$  _____|$$ |$$  _____|
            $$ |      $$ /  $$ |$$ /  $$ |$$$$$$$$ |      $$ \$$$  $$ |$$ |  $$ |\$$$$$$\  $$ |$$ /      
            $$ |  $$\ $$ |  $$ |$$ |  $$ |$$   ____|      $$ |\$  /$$ |$$ |  $$ | \____$$\ $$ |$$ |      
            \$$$$$$  |\$$$$$$  |\$$$$$$$ |\$$$$$$$\       $$ | \_/ $$ |\$$$$$$  |$$$$$$$  |$$ |\$$$$$$$\ 
            \______/  \______/  \_______| \_______|      \__|     \__| \______/ \_______/ \__| \_______|
                                                                                                        '.colorize(:blue)]
    end
```
# Gems Used  
1. ***'rspec'***  
   This gem is used to do rspec test for the programme. There are 3 main methods are tested in this section. You can use code of ***'rspec'*** to check the testing result in ***'src'*** folder. I choose serveral important calculation and produts showing methods to be tested. The codes are below.  
```ruby
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
```
   The rspec test can be executed by using 'rspec' code under the path of 'src' folder. The result is shown below.  
   ![result of rspec](/docs/Screen%20Shot%202022-04-17%20at%2018.39.48.png)
2. ***'tty-table'***  
   ***'tty-table'*** is another ruby gem used in this programme. For this programme, ***'tty-table'*** is used to establish the table of the products. The code is shown below.  
```ruby
   LISTTABLE = TTY::Table.new(["Guitar", "Amplifier", "Pedal"], [["tele: 1600", "fishman: 650", "overdrive: 216"], ["gibson sg: 2336","marshall: 989", "reverb: 158"], ["stra: 1443", "blackstar: 455", "delay: 188"], ["maton: 1899","mesa: 999", "looper: 466"]])
```
   The code call this table is shown below.  
```ruby
   puts (ProductList::LISTTABLE).render(:ascii).colorize(:blue) # show the table of product list by using tty-table
```
   The result is like this.  
   ![result of tty-table](/docs/Screen%20Shot%202022-04-17%20at%2019.46.46.png)  
3. ***'colorize'***  
   This is the last ruby gem used in this programme. It is used to change the color of the text.   
   ![result of colorize](/docs/Screen%20Shot%202022-04-17%20at%2019.53.16.png)
   ![result of colorize](/docs/Screen%20Shot%202022-04-17%20at%2019.54.46.png)
# Features  
#### 1. Shopping loop system   
This feature lets the customers continue to shop if they want to buy more products. I use boolean to control the end of the shopping like this. The notes give the explaination of every line of code.  
```ruby
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
```
#### 2. Payment methods (cash or card)  
the payment method depends on customers' choice. If they want to choose card, every thing gonna be easy, because they just need to tap the card. However, if they choose cash, the changes need to be calculated by the method. If the money customers insert is not enough, the programme will tell them to insert more money and all these money will be added together until the money is enough to pay.  
```ruby
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
```
#### 3. Exception handling  
This programme will let customer insert many text, so in order to prevent wrong inserts, the codes shown below are used.  
```ruby
begin # use exception handling
    type = ProductList::LIST[music_instrument_type.to_sym]
    show_price_list(type)
    rescue NoMethodError
        puts "Please insert guitar, amplifier or pedal.".colorize(:red) # if customer did not insert correct words of 'guitar', 'amplifier' and 'pedal', puts this to tell customer they insert wrong word
    end
end
```
If the customer insert a wrong word, the system will let them know which words are valid. The hint is like this in red.  
![Exceptional Handling](/docs/Screen%20Shot%202022-04-17%20at%2020.18.43.png)
![Exceptional Handling](/docs/Screen%20Shot%202022-04-17%20at%2020.19.19.png)

# Example Test

1. Test choose pay by card:  
   
![test1](/docs/Screen%20Shot%202022-04-22%20at%2011.24.22.png)
1. Test choose pay by cash:  
   
![test1](/docs/Screen%20Shot%202022-04-22%20at%2011.24.52.png)