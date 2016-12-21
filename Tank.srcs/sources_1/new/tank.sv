`timescale 1ns / 1ps

module tank(
    input logic mclk,
    input logic reset,
    logic [3:0] command,
    input logic tankNo,
    output logic [9:0] pos0, pos1, pos2, pos3, pos4, pos5, pos6, pos7,  //tankTop, tankBottom, tankLeft, tankRight
    output logic [2:0] nDirection,
    output logic isObject
    );
    
parameter fFPTankTop = 300;    //First tank initial position
parameter fFPTankBottom = 340;    
parameter fFPTankLeft = 200;    
parameter fFPTankRight = 230;    
parameter fFPHeadTop = 292;    //First head initial position
parameter fFPHeadBottom = 300;    
parameter fFPHeadLeft = 212;    
parameter fFPHeadRight = 218;    
parameter sFPTankTop = 400;    //Second tank initial position
parameter sFPTankBottom = 440;    
parameter sFPTankLeft = 300;    
parameter sFPTankRight = 330;
parameter sFPHeadTop = 392;    //Second head initial position
parameter sFPHeadBottom = 400;    
parameter sFPHeadLeft = 312;    
parameter sFPHeadRight = 318;  

logic [9:0] nPos0, nPos1, nPos2, nPos3, nPos4, nPos5, nPos6, nPos7;    
logic [2:0] direction;
logic [1:0] way;

move m1( direction, way, pos0, pos1, pos2, pos3, pos4, pos5, pos6, pos7, nPos0, nPos1, nPos2, nPos3, nPos4, nPos5, nPos6, nPos7, nDirection);
objectCol obj(nPos0, nPos1, nPos2, nPos3, nPos4, nPos5, nPos6, nPos7, isObject);

always_ff @( posedge reset or posedge mclk)
begin
    if ( reset)
    begin
        //State = 0
        if ( tankNo == 0)
        begin
            pos0 <= fFPTankTop;
            pos1 <= fFPTankBottom;
            pos2 <= fFPTankLeft;
            pos3 <= fFPTankRight;   
            pos4 <= fFPHeadTop;
            pos5 <= fFPHeadBottom;
            pos6 <= fFPHeadLeft;
            pos7 <= fFPHeadRight;  
        end
        else if ( tankNo == 1)
        begin
            pos0 <= sFPTankTop;
            pos1 <= sFPTankBottom;
            pos2 <= sFPTankLeft;
            pos3 <= sFPTankRight;    
            pos4 <= sFPHeadTop;
            pos5 <= sFPHeadBottom;
            pos6 <= sFPHeadLeft;
            pos7 <= sFPHeadRight; 
        end
        direction <= 3'b000;
    end
    else
    begin
        if ( command > 4'b0000)
        begin
            if ( isObject == 0)
            begin
                direction <= nDirection;      
                //NextState
                pos0 <= nPos0;
                pos1 <= nPos1;
                pos2 <= nPos2;
                pos3 <= nPos3;   
                pos4 <= nPos4;
                pos5 <= nPos5;
                pos6 <= nPos6;
                pos7 <= nPos7;
            end
        end   
    end    
end

always_comb
begin
    if ( command[0])
    begin
        way = 2'b00;
    end
    if ( command[2])
    begin
        way = 2'b10;
    end
    if ( command[1])
    begin
        way = 2'b01;
    end
    if ( command[3])
    begin
        way = 2'b11;
    end
end	

endmodule
