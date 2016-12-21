`timescale 1ns / 1ps

module clkdiv(
	input logic clk,		//master clock: 100MHz
	output logic dclk,		//pixel clock: 25MHz
	output logic mclk //motion clock : half second
	);

    logic [2:0] counter;
    logic [30:0] mCounter;
    
    logic temporal = 0;
    logic mTemporal = 0;
    logic [30:0] d = 20000000;

    
    //VGA clock
    always @(posedge clk)
    begin
        if ( counter >= 3)
        begin
            temporal = 1;
        end
        if ( counter <= 2)
            temporal = 0;
        if ( counter == 4)
            counter = 0;
                
        counter = counter + 1;  
    end
    
    assign dclk = temporal;
    
    //Motion
    always @( posedge clk)
    begin
        if ( mCounter > d/2)
        begin
            mTemporal = 1;
        end
        if ( mCounter <= d/2)
            mTemporal = 0;
        if ( mCounter == d)
            mCounter = 0;
                
        mCounter = mCounter + 1;  
    end
    
    assign mclk = mTemporal;
    

endmodule
