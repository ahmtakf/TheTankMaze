`timescale 1ns / 1ps

module tankGame(
	input logic clk,			//master clock = 50MHz
	input logic reset,			//right-most pushbutton for reset
	input logic [3:0] p1Command, //Command tank1 move back turn left right
	input logic [3:0] p2Command, //Command tank2 move back turn left right
	output logic [2:0] red,	//red vga output - 3 bits
	output logic [2:0] green,//green vga output - 3 bits
	output logic [1:0] blue,	//blue vga output - 2 bits
	output logic hsync,		//horizontal sync out
	output logic vsync	,	//vertical sync out
	output logic led1,
	output logic led2
	);
// VGA display clock interconnect
logic dclk, mclk;
logic inDisplayArea;
logic [9:0] hc,vc;
logic [9:0] ft0, st0;//TAnk
logic [9:0] ft1, st1;
logic [9:0] ft2, st2;
logic [9:0] ft3, st3;
logic [9:0] ft4, st4;//HEad
logic [9:0] ft5, st5;
logic [9:0] ft6, st6;
logic [9:0] ft7, st7;

logic [2:0] fDirection;
logic [2:0] sDirection;
logic [5:0] fCounterHL, fCounterHR, fCounterTL, fCounterTR;
logic [5:0] sCounterHL, sCounterHR, sCounterTL, sCounterTR;

parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch
parameter headS = 10; //Head 

parameter obj1Top = 150; //Obje1
parameter obj1Bottom = 180;
parameter obj1Left = 0;
parameter obj1Right = 300;
parameter obj2Top = 150; //Obje2
parameter obj2Bottom = 350;
parameter obj2Left = 500;
parameter obj2Right = 530;


// generate & display clock
clkdiv clkdiv1( clk, dclk, mclk);

// VGA controller
VGA VGA1( dclk, reset, hsync, vsync, inDisplayArea, hc, vc);
	
tank t1( mclk, reset, p1Command, 0, ft0, ft1, ft2, ft3, ft4, ft5, ft6, ft7, fDirection, led1);
tank t2( mclk, reset, p2Command, 1, st0, st1, st2, st3, st4, st5, st6, st7, sDirection, led2);

counterGenerator cg1( hc, vc, fDirection, ft0, ft1, ft2, ft3, ft4, ft5, ft6, ft7, fCounterHL, fCounterHR, fCounterTL, fCounterTR);    
counterGenerator cg2( hc, vc, sDirection, st0, st1, st2, st3, st4, st5, st6, st7, sCounterHL, sCounterHR, sCounterTL, sCounterTR);    
	
	
	always @( posedge dclk)
	begin
	   if ( inDisplayArea)
	   begin 
	       if ( vc >= vbp + obj1Top  && vc < vbp + obj1Bottom && hc >= hbp + obj1Left && hc < hbp + obj1Right)
	       begin
	           red = 3'b111;
               green = 3'b110;
               blue = 2'b11;
	       end
	       else if ( vc >= vbp + obj2Top  && vc < vbp + obj2Bottom && hc >= hbp + obj2Left && hc < hbp + obj2Right)
	       begin
	           red = 3'b111;
               green = 3'b110;
               blue = 2'b11;
	       end 
           //Draw First
           else if ( vc >= vbp + ft4  && vc < vbp + ft5 && hc >= hbp + ft6 + fCounterHL && hc < hbp + ft7 - fCounterHR)
           begin
               red = 3'b111;
               green = 0;
               blue = 0;
           end
           else if ( vc >= vbp + ft0 && vc < vbp + ft1 && hc >= hbp + ft2 + fCounterTL && hc < hbp + ft3 - fCounterTR)
           begin
               red = 3'b111;
               green = 0;
               blue = 0;
           end
           //Draw Second 
           else if ( vc >= vbp + st4  && vc < vbp + st5 && hc >= hbp + st6 + sCounterHL && hc < hbp + st7 - sCounterHR)
           begin
               red = 0;
               green = 0;
               blue = 2'b11;
           end
           else if ( vc >= vbp + st0 && vc < vbp + st1 && hc >= hbp + st2 + sCounterTL && hc < hbp + st3 - sCounterTR)
           begin
               red = 0;
               green = 0;
               blue = 2'b11;
           end
	       else
	       begin
	           red = 0;
	           green = 3'b111;
	           blue = 0;
	       end
	   end
	   else
	   begin
	       red = 0;
	       green = 0;
	       blue = 0;
	   end
	end

endmodule
