module Service  #basic shop service processes are here. Other stores also can use them. 
    def welcome (store_name)
        puts "Welcome to #{store_name}."
    end

    def pay_by_card
        puts "Please tap here."
    end

    def pay_by_cash(money_need_to_be_paid, money_customer_paid)
        changes = money_customer_paid - money_need_to_be_paid
        puts "Please check your changes, #{changes.round(2)} dollar."
    end

    def goodbye
        puts "Thank you for your coming and have a good day."
    end

end



