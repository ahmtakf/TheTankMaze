`timescale 1ns / 1ps

module move(
    input logic [2:0] direction,
    input logic [1:0] way,
    input logic [9:0] cPos0, cPos1, cPos2, cPos3, cPos4, cPos5, cPos6, cPos7, 
    output logic [9:0] nPos0, nPos1, nPos2, nPos3, nPos4, nPos5, nPos6, nPos7,  //tankTop, tankBottom, tankLeft, tankRight, headTop, headBottom, headLeft, headRight
    output logic [2:0] nDirection
    );
    
 parameter dp = 10; // when moving or backing
 parameter dc = 7;
 parameter dTw = 10; // when turning tank
 parameter dTh = 5;
 parameter dHl = 22; // when turning head
 parameter dHs = 12;
 parameter tankHeight = 40;
 parameter tankWeight = 30;
 parameter headHeight = 8;
 parameter headWeight = 6;
 

/*
way == 00 move
way == 01 left
way == 10 back
way == 11 right
direction == 000 up
direction == 001 up left
direction == 010 left
direction == 011 down left
direction == 100 down
direction == 101 down right
direction == 110 right
direction == 111 up right
*/

always_comb
begin
    //direction up
    if ( direction == 3'b000)
    begin
        //way move
        if ( way == 2'b00)
        begin
            nDirection = 3'b000; 
            nPos0 = cPos0 - dp;
            nPos1 = cPos1 - dp;
            nPos2 = cPos2;
            nPos3 = cPos3;   
            nPos4 = cPos4 - dp;
            nPos5 = cPos5 - dp;
            nPos6 = cPos6;
            nPos7 = cPos7;  
        end
        else if ( way == 2'b01)
        begin
            nDirection = 3'b001; 
            nPos0 = cPos0 - dTh;
            nPos1 = cPos1 + dTh;
            nPos2 = cPos2 - dTw;
            nPos3 = cPos3 + dTw;   
            nPos4 = ( cPos1 - cPos0) / 2 + cPos0 - dHl;
            nPos5 = ( cPos1 - cPos0) / 2 + cPos0 - dHs;
            nPos6 = ( cPos3 - cPos2) / 2 + cPos2 - dHl;
            nPos7 = ( cPos3 - cPos2) / 2 + cPos2 - dHs;  
        end
        else if ( way == 2'b10)
        begin
            nDirection = 3'b000; 
            nPos0 = cPos0 + dp;
            nPos1 = cPos1 + dp;
            nPos2 = cPos2;
            nPos3 = cPos3;   
            nPos4 = cPos4 + dp;
            nPos5 = cPos5 + dp;
            nPos6 = cPos6;
            nPos7 = cPos7;  
        end
        else if ( way == 2'b11)
        begin
            nDirection = 3'b111; 
            nPos0 = cPos0 - dTh;
            nPos1 = cPos1 + dTh;
            nPos2 = cPos2 - dTw;
            nPos3 = cPos3 + dTw;   
            nPos4 = ( cPos1 - cPos0) / 2 + cPos0 - dHl;
            nPos5 = ( cPos1 - cPos0) / 2 + cPos0 - dHs;
            nPos6 = ( cPos3 - cPos2) / 2 + cPos2 + dHs;
            nPos7 = ( cPos3 - cPos2) / 2 + cPos2 + dHl; 
        end
        else
        begin
            nDirection = direction; 
            nPos0 = cPos0;
            nPos1 = cPos1;
            nPos2 = cPos2;
            nPos3 = cPos3;   
            nPos4 = cPos4;
            nPos5 = cPos5;
            nPos6 = cPos6;
            nPos7 = cPos7;
        end
    end
    //direction up left
    else if ( direction == 3'b001)
    begin
        //way move
        if ( way == 2'b00)
        begin
            nDirection = 3'b001; 
            nPos0 = cPos0 - dc;
            nPos1 = cPos1 - dc;
            nPos2 = cPos2 - dc;
            nPos3 = cPos3 - dc;   
            nPos4 = cPos4 - dc;
            nPos5 = cPos5 - dc;
            nPos6 = cPos6 - dc;
            nPos7 = cPos7 - dc;  
        end
        else if ( way == 2'b01)
        begin
            nDirection = 3'b010; 
            nPos0 = ( cPos1 - cPos0) / 2 + cPos0 - tankWeight / 2;
            nPos1 = ( cPos1 - cPos0) / 2 + cPos0 + tankWeight / 2;
            nPos2 = ( cPos3 - cPos2) / 2 + cPos2 - tankHeight / 2;
            nPos3 = ( cPos3 - cPos2) / 2 + cPos2 + tankHeight / 2;   
            nPos4 = ( cPos1 - cPos0) / 2 + cPos0 - headWeight / 2;
            nPos5 = ( cPos1 - cPos0) / 2 + cPos0 + headWeight / 2;
            nPos6 = nPos2 - headHeight;
            nPos7 = nPos2;  
        end
        else if ( way == 2'b10)
        begin
            nDirection = 3'b001; 
            nPos0 = cPos0 + dc;
            nPos1 = cPos1 + dc;
            nPos2 = cPos2 + dc;
            nPos3 = cPos3 + dc;   
            nPos4 = cPos4 + dc;
            nPos5 = cPos5 + dc;
            nPos6 = cPos6 + dc;
            nPos7 = cPos7 + dc;  
        end
        else if ( way == 2'b11)
        begin
            nDirection = 3'b000; 
            nPos0 = ( cPos1 - cPos0) / 2 + cPos0 - tankHeight / 2;
            nPos1 = ( cPos1 - cPos0) / 2 + cPos0 + tankHeight / 2;
            nPos2 = ( cPos3 - cPos2) / 2 + cPos2 - tankWeight / 2;
            nPos3 = ( cPos3 - cPos2) / 2 + cPos2 + tankWeight / 2;   
            nPos4 = nPos0 - headHeight;
            nPos5 = nPos0;
            nPos6 = ( cPos3 - cPos2) / 2 + cPos2 - headWeight / 2;
            nPos7 = ( cPos3 - cPos2) / 2 + cPos2 + headWeight / 2; 
        end
        else
        begin
            nDirection = direction; 
            nPos0 = cPos0;
            nPos1 = cPos1;
            nPos2 = cPos2;
            nPos3 = cPos3;   
            nPos4 = cPos4;
            nPos5 = cPos5;
            nPos6 = cPos6;
            nPos7 = cPos7;
        end
    end
    //direction left
    else if ( direction == 3'b010)
    begin
        //way move
        if ( way == 2'b00)
        begin
            nDirection = 3'b010; 
            nPos0 = cPos0;
            nPos1 = cPos1;
            nPos2 = cPos2 - dp;
            nPos3 = cPos3 - dp;   
            nPos4 = cPos4;
            nPos5 = cPos5;
            nPos6 = cPos6 - dp;
            nPos7 = cPos7 - dp;  
        end
        else if ( way == 2'b01)
        begin
            nDirection = 3'b011; 
            nPos0 = cPos0 - dTw;
            nPos1 = cPos1 + dTw;
            nPos2 = cPos2 - dTh;
            nPos3 = cPos3 + dTh;   
            nPos4 = ( cPos1 - cPos0) / 2 + cPos0 + dHs;
            nPos5 = ( cPos1 - cPos0) / 2 + cPos0 + dHl;
            nPos6 = ( cPos3 - cPos2) / 2 + cPos2 - dHl;
            nPos7 = ( cPos3 - cPos2) / 2 + cPos2 - dHs;  
        end
        else if ( way == 2'b10)
        begin
            nDirection = 3'b010; 
            nPos0 = cPos0;
            nPos1 = cPos1;
            nPos2 = cPos2 + dp;
            nPos3 = cPos3 + dp;   
            nPos4 = cPos4;
            nPos5 = cPos5;
            nPos6 = cPos6 + dp;
            nPos7 = cPos7 + dp;  
        end
        else if ( way == 2'b11)
        begin
            nDirection = 3'b001; 
            nPos0 = cPos0 - dTw;
            nPos1 = cPos1 + dTw;
            nPos2 = cPos2 - dTh;
            nPos3 = cPos3 + dTh;   
            nPos4 = ( cPos1 - cPos0) / 2 + cPos0 - dHl;
            nPos5 = ( cPos1 - cPos0) / 2 + cPos0 - dHs;
            nPos6 = ( cPos3 - cPos2) / 2 + cPos2 - dHl;
            nPos7 = ( cPos3 - cPos2) / 2 + cPos2 - dHs; 
        end
        else
        begin
            nDirection = direction; 
            nPos0 = cPos0;
            nPos1 = cPos1;
            nPos2 = cPos2;
            nPos3 = cPos3;   
            nPos4 = cPos4;
            nPos5 = cPos5;
            nPos6 = cPos6;
            nPos7 = cPos7;
        end
    end
    //direction down left
    else if ( direction == 3'b011)
    begin
        //way move
        if ( way == 2'b00)
        begin
            nDirection = 3'b011; 
            nPos0 = cPos0 + dc;
            nPos1 = cPos1 + dc;
            nPos2 = cPos2 - dc;
            nPos3 = cPos3 - dc;
            nPos4 = cPos4 + dc;
            nPos5 = cPos5 + dc;
            nPos6 = cPos6 - dc;
            nPos7 = cPos7 - dc;
        end
        else if ( way == 2'b01)
        begin
            nDirection = 3'b100; 
            nPos0 = ( cPos1 - cPos0) / 2 + cPos0 - tankHeight / 2;
            nPos1 = ( cPos1 - cPos0) / 2 + cPos0 + tankHeight / 2;
            nPos2 = ( cPos3 - cPos2) / 2 + cPos2 - tankWeight / 2;
            nPos3 = ( cPos3 - cPos2) / 2 + cPos2 + tankWeight / 2;   
            nPos4 = nPos1;
            nPos5 = nPos1 + headHeight;
            nPos6 = ( cPos3 - cPos2) / 2 + cPos2 - headWeight / 2;
            nPos7 = ( cPos3 - cPos2) / 2 + cPos2 + headWeight / 2;  
        end
        else if ( way == 2'b10)
        begin
            nDirection = 3'b011; 
            nPos0 = cPos0 - dc;
            nPos1 = cPos1 - dc;
            nPos2 = cPos2 + dc;
            nPos3 = cPos3 + dc;   
            nPos4 = cPos4 - dc;
            nPos5 = cPos5 - dc;
            nPos6 = cPos6 + dc;
            nPos7 = cPos7 + dc;  
        end
        else if ( way == 2'b11)
        begin
            nDirection = 3'b010; 
            nPos0 = ( cPos1 - cPos0) / 2 + cPos0 - tankWeight / 2;
            nPos1 = ( cPos1 - cPos0) / 2 + cPos0 + tankWeight / 2;
            nPos2 = ( cPos3 - cPos2) / 2 + cPos2 - tankHeight / 2;
            nPos3 = ( cPos3 - cPos2) / 2 + cPos2 + tankHeight / 2;   
            nPos4 = ( cPos1 - cPos0) / 2 + cPos0 - headWeight / 2;
            nPos5 = ( cPos1 - cPos0) / 2 + cPos0 + headWeight / 2;
            nPos6 = nPos2 - headHeight;
            nPos7 = nPos2;  
        end
        else
        begin
            nDirection = direction; 
            nPos0 = cPos0;
            nPos1 = cPos1;
            nPos2 = cPos2;
            nPos3 = cPos3;   
            nPos4 = cPos4;
            nPos5 = cPos5;
            nPos6 = cPos6;
            nPos7 = cPos7;
        end
    end
    //direction down
    else if ( direction == 3'b100)
    begin
        //way move
        if ( way == 2'b00)
        begin
            nDirection = 3'b100; 
            nPos0 = cPos0 + dp;
            nPos1 = cPos1 + dp;
            nPos2 = cPos2;
            nPos3 = cPos3;
            nPos4 = cPos4 + dp;
            nPos5 = cPos5 + dp;
            nPos6 = cPos6;
            nPos7 = cPos7;
        end
        else if ( way == 2'b01)
        begin
            nDirection = 3'b101; 
            nPos0 = cPos0 - dTh;
            nPos1 = cPos1 + dTh;
            nPos2 = cPos2 - dTw;
            nPos3 = cPos3 + dTw;   
            nPos4 = ( cPos1 - cPos0) / 2 + cPos0 + dHs;
            nPos5 = ( cPos1 - cPos0) / 2 + cPos0 + dHl;
            nPos6 = ( cPos3 - cPos2) / 2 + cPos2 + dHs;
            nPos7 = ( cPos3 - cPos2) / 2 + cPos2 + dHl;  
        end
        else if ( way == 2'b10)
        begin
            nDirection = 3'b100; 
            nPos0 = cPos0 - dp;
            nPos1 = cPos1 - dp;
            nPos2 = cPos2;
            nPos3 = cPos3;   
            nPos4 = cPos4 - dp;
            nPos5 = cPos5 - dp;
            nPos6 = cPos6;
            nPos7 = cPos7;  
        end
        else if ( way == 2'b11)
        begin
            nDirection = 3'b011; 
            nPos0 = cPos0 - dTh;
            nPos1 = cPos1 + dTh;
            nPos2 = cPos2 - dTw;
            nPos3 = cPos3 + dTw;   
            nPos4 = ( cPos1 - cPos0) / 2 + cPos0 + dHs;
            nPos5 = ( cPos1 - cPos0) / 2 + cPos0 + dHl;
            nPos6 = ( cPos3 - cPos2) / 2 + cPos2 - dHl;
            nPos7 = ( cPos3 - cPos2) / 2 + cPos2 - dHs;  
        end
        else
        begin
            nDirection = direction; 
            nPos0 = cPos0;
            nPos1 = cPos1;
            nPos2 = cPos2;
            nPos3 = cPos3;   
            nPos4 = cPos4;
            nPos5 = cPos5;
            nPos6 = cPos6;
            nPos7 = cPos7;
        end
    end
    //direction down right
    else if ( direction == 3'b101)
    begin
        //way move
        if ( way == 2'b00)
        begin
            nDirection = 3'b101; 
            nPos0 = cPos0 + dc;
            nPos1 = cPos1 + dc;
            nPos2 = cPos2 + dc;
            nPos3 = cPos3 + dc;
            nPos4 = cPos4 + dc;
            nPos5 = cPos5 + dc;
            nPos6 = cPos6 + dc;
            nPos7 = cPos7 + dc;
        end
        else if ( way == 2'b01)
        begin
            nDirection = 3'b110; 
            nPos0 = ( cPos1 - cPos0) / 2 + cPos0 - tankWeight / 2;
            nPos1 = ( cPos1 - cPos0) / 2 + cPos0 + tankWeight / 2;
            nPos2 = ( cPos3 - cPos2) / 2 + cPos2 - tankHeight / 2;
            nPos3 = ( cPos3 - cPos2) / 2 + cPos2 + tankHeight / 2;   
            nPos4 = ( cPos1 - cPos0) / 2 + cPos0 - headWeight / 2;
            nPos5 = ( cPos1 - cPos0) / 2 + cPos0 + headWeight / 2;
            nPos6 = nPos3;
            nPos7 = nPos3 + headHeight;  
        end
        else if ( way == 2'b10)
        begin
            nDirection = 3'b101; 
            nPos0 = cPos0 - dc;
            nPos1 = cPos1 - dc;
            nPos2 = cPos2 - dc;
            nPos3 = cPos3 - dc;   
            nPos4 = cPos4 - dc;
            nPos5 = cPos5 - dc;
            nPos6 = cPos6 - dc;
            nPos7 = cPos7 - dc;  
        end
        else if ( way == 2'b11)
        begin
            nDirection = 3'b100; 
            nPos0 = ( cPos1 - cPos0) / 2 + cPos0 - tankHeight / 2;
            nPos1 = ( cPos1 - cPos0) / 2 + cPos0 + tankHeight / 2;
            nPos2 = ( cPos3 - cPos2) / 2 + cPos2 - tankWeight / 2;
            nPos3 = ( cPos3 - cPos2) / 2 + cPos2 + tankWeight / 2;   
            nPos4 = nPos1;
            nPos5 = nPos1 + headHeight;
            nPos6 = ( cPos3 - cPos2) / 2 + cPos2 - headWeight / 2;
            nPos7 = ( cPos3 - cPos2) / 2 + cPos2 + headWeight / 2;   
        end
        else
        begin
            nDirection = direction; 
            nPos0 = cPos0;
            nPos1 = cPos1;
            nPos2 = cPos2;
            nPos3 = cPos3;   
            nPos4 = cPos4;
            nPos5 = cPos5;
            nPos6 = cPos6;
            nPos7 = cPos7;
        end
    end
    //direction right
    else if ( direction == 3'b110)
    begin
        //way move
        if ( way == 2'b00)
        begin
            nDirection = 3'b110; 
            nPos0 = cPos0;
            nPos1 = cPos1;
            nPos2 = cPos2 + dp;
            nPos3 = cPos3 + dp;
            nPos4 = cPos4;
            nPos5 = cPos5;
            nPos6 = cPos6 + dp;
            nPos7 = cPos7 + dp;
        end
        else if ( way == 2'b01)
        begin
            nDirection = 3'b111; 
            nPos0 = cPos0 - dTw;
            nPos1 = cPos1 + dTw;
            nPos2 = cPos2 - dTh;
            nPos3 = cPos3 + dTh;   
            nPos4 = ( cPos1 - cPos0) / 2 + cPos0 - dHl;
            nPos5 = ( cPos1 - cPos0) / 2 + cPos0 - dHs;
            nPos6 = ( cPos3 - cPos2) / 2 + cPos2 + dHs;
            nPos7 = ( cPos3 - cPos2) / 2 + cPos2 + dHl;  
       end
        else if ( way == 2'b10)
        begin
            nDirection = 3'b110; 
            nPos0 = cPos0;
            nPos1 = cPos1;
            nPos2 = cPos2 - dp;
            nPos3 = cPos3 - dp;   
            nPos4 = cPos4;
            nPos5 = cPos5;
            nPos6 = cPos6 - dp;
            nPos7 = cPos7 - dp;  
        end
        else if ( way == 2'b11)
        begin
            nDirection = 3'b101; 
            nPos0 = cPos0 - dTw;
            nPos1 = cPos1 + dTw;
            nPos2 = cPos2 - dTh;
            nPos3 = cPos3 + dTh;   
            nPos4 = ( cPos1 - cPos0) / 2 + cPos0 + dHs;
            nPos5 = ( cPos1 - cPos0) / 2 + cPos0 + dHl;
            nPos6 = ( cPos3 - cPos2) / 2 + cPos2 + dHs;
            nPos7 = ( cPos3 - cPos2) / 2 + cPos2 + dHl;   
        end
        else
        begin
            nDirection = direction; 
            nPos0 = cPos0;
            nPos1 = cPos1;
            nPos2 = cPos2;
            nPos3 = cPos3;   
            nPos4 = cPos4;
            nPos5 = cPos5;
            nPos6 = cPos6;
            nPos7 = cPos7;
        end
    end
    //direction up right
    else if ( direction == 3'b111)
    begin
        //way move
        if ( way == 2'b00)
        begin
            nDirection = 3'b111; 
            nPos0 = cPos0 - dc;
            nPos1 = cPos1 - dc;
            nPos2 = cPos2 + dc;
            nPos3 = cPos3 + dc;
            nPos4 = cPos4 - dc;
            nPos5 = cPos5 - dc;
            nPos6 = cPos6 + dc;
            nPos7 = cPos7 + dc;
        end
        else if ( way == 2'b01)
        begin
            nDirection = 3'b000; 
            nPos0 = ( cPos1 - cPos0) / 2 + cPos0 - tankHeight / 2;
            nPos1 = ( cPos1 - cPos0) / 2 + cPos0 + tankHeight / 2;
            nPos2 = ( cPos3 - cPos2) / 2 + cPos2 - tankWeight / 2;
            nPos3 = ( cPos3 - cPos2) / 2 + cPos2 + tankWeight / 2;   
            nPos4 = nPos0 - headHeight;
            nPos5 = nPos0;
            nPos6 = ( cPos3 - cPos2) / 2 + cPos2 - headWeight / 2;
            nPos7 = ( cPos3 - cPos2) / 2 + cPos2 + headWeight / 2;  
        end
        else if ( way == 2'b10)
        begin
            nDirection = 3'b111; 
            nPos0 = cPos0 + dc;
            nPos1 = cPos1 + dc;
            nPos2 = cPos2 - dc;
            nPos3 = cPos3 - dc;   
            nPos4 = cPos4 + dc;
            nPos5 = cPos5 + dc;
            nPos6 = cPos6 - dc;
            nPos7 = cPos7 - dc;  
        end
        else if ( way == 2'b11)
        begin
            nDirection = 3'b110; 
            nPos0 = ( cPos1 - cPos0) / 2 + cPos0 - tankWeight / 2;
            nPos1 = ( cPos1 - cPos0) / 2 + cPos0 + tankWeight / 2;
            nPos2 = ( cPos3 - cPos2) / 2 + cPos2 - tankHeight / 2;
            nPos3 = ( cPos3 - cPos2) / 2 + cPos2 + tankHeight / 2;   
            nPos4 = ( cPos1 - cPos0) / 2 + cPos0 - headWeight / 2;
            nPos5 = ( cPos1 - cPos0) / 2 + cPos0 + headWeight / 2;
            nPos6 = nPos3;
            nPos7 = nPos3 + headHeight;  
        end
        else
        begin
            nDirection = direction; 
            nPos0 = cPos0;
            nPos1 = cPos1;
            nPos2 = cPos2;
            nPos3 = cPos3;   
            nPos4 = cPos4;
            nPos5 = cPos5;
            nPos6 = cPos6;
            nPos7 = cPos7;
        end
    end        
    else
    begin
        nDirection = direction; 
        nPos0 = cPos0;
        nPos1 = cPos1;
        nPos2 = cPos2;
        nPos3 = cPos3;   
        nPos4 = cPos4;
        nPos5 = cPos5;
        nPos6 = cPos6;
        nPos7 = cPos7;
    end
end
endmodule
