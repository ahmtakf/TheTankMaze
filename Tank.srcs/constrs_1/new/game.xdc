# Clock signal 
set_property PACKAGE_PIN W5 [get_ports clk]  	 	 	 	  
 	set_property IOSTANDARD LVCMOS33 [get_ports clk] 
 create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk] 
 
 #VGA Connector 
 set_property PACKAGE_PIN G19 [get_ports {red[0]}]                     
      set_property IOSTANDARD LVCMOS33 [get_ports {red[0]}] 
 set_property PACKAGE_PIN H19 [get_ports {red[1]}]                     
      set_property IOSTANDARD LVCMOS33 [get_ports {red[1]}] 
 set_property PACKAGE_PIN J19 [get_ports {red[2]}]                     
      set_property IOSTANDARD LVCMOS33 [get_ports {red[2]}] 
 set_property PACKAGE_PIN N18 [get_ports {blue[0]}]                     
      set_property IOSTANDARD LVCMOS33 [get_ports {blue[0]}] 
 set_property PACKAGE_PIN L18 [get_ports {blue[1]}]                              
       set_property IOSTANDARD LVCMOS33 [get_ports {blue[1]}] 
 set_property PACKAGE_PIN J17 [get_ports {green[0]}]                 
      set_property IOSTANDARD LVCMOS33 [get_ports {green[0]}] 
 set_property PACKAGE_PIN H17 [get_ports {green[1]}]                 
      set_property IOSTANDARD LVCMOS33 [get_ports {green[1]}] 
 set_property PACKAGE_PIN G17 [get_ports {green[2]}]                 
      set_property IOSTANDARD LVCMOS33 [get_ports {green[2]}] 
 set_property PACKAGE_PIN P19 [get_ports hsync]                          
      set_property IOSTANDARD LVCMOS33 [get_ports hsync] 
 set_property PACKAGE_PIN R19 [get_ports vsync]                          
      set_property IOSTANDARD LVCMOS33 [get_ports vsync]

set_property PACKAGE_PIN U18 [get_ports {reset}]                          
      set_property IOSTANDARD LVCMOS33 [get_ports {reset}] 

#p1Command buttons
                
set_property PACKAGE_PIN T18 [get_ports {p1Command[0]}]                          
      set_property IOSTANDARD LVCMOS33 [get_ports {p1Command[0]}] 
set_property PACKAGE_PIN U17 [get_ports {p1Command[2]}]                          
      set_property IOSTANDARD LVCMOS33 [get_ports {p1Command[2]}] 
set_property PACKAGE_PIN W19 [get_ports {p1Command[1]}]                          
      set_property IOSTANDARD LVCMOS33 [get_ports {p1Command[1]}] 
set_property PACKAGE_PIN T17 [get_ports {p1Command[3]}]                          
      set_property IOSTANDARD LVCMOS33 [get_ports {p1Command[3]}] 

#p2Command buttons
                
set_property PACKAGE_PIN P18 [get_ports {p2Command[0]}]                          
      set_property IOSTANDARD LVCMOS33 [get_ports {p2Command[0]}] 
set_property PACKAGE_PIN N17 [get_ports {p2Command[2]}]                          
      set_property IOSTANDARD LVCMOS33 [get_ports {p2Command[2]}] 
set_property PACKAGE_PIN M18 [get_ports {p2Command[1]}]                          
      set_property IOSTANDARD LVCMOS33 [get_ports {p2Command[1]}] 
set_property PACKAGE_PIN K17 [get_ports {p2Command[3]}]                          
      set_property IOSTANDARD LVCMOS33 [get_ports {p2Command[3]}]       
      
      set_property PACKAGE_PIN U19 [get_ports {led1}]                          
            set_property IOSTANDARD LVCMOS33 [get_ports {led1}]       
            set_property PACKAGE_PIN E19 [get_ports {led2}]                          
                  set_property IOSTANDARD LVCMOS33 [get_ports {led2}]       