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
