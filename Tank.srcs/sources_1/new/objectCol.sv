`timescale 1ns / 1ps

module objectCol(
    input logic [9:0] nPos0, nPos1, nPos2, nPos3, nPos4, nPos5, nPos6, nPos7,
    output logic isObject
    );
    
parameter obj1Top = 150; //Obje1
    parameter obj1Bottom = 180;
    parameter obj1Left = 0;
    parameter obj1Right = 300;
    parameter obj2Top = 150; //Obje2
    parameter obj2Bottom = 350;
    parameter obj2Left = 500;
    parameter obj2Right = 530;
    
    always_comb
    begin
        //Object 
        if ( (((nPos4 >= obj1Top  && nPos4 < obj1Bottom) || (nPos5 >= obj1Top  && nPos5 < obj1Bottom)) && ((nPos6 >= obj1Left && nPos6 < obj1Right) || (nPos7 >= obj1Left && nPos7 < obj1Right))) || (((nPos0 >= obj1Top  && nPos0 < obj1Bottom) || (nPos1 >= obj1Top  && nPos1 < obj1Bottom)) && ((nPos2 >= obj1Left && nPos2 < obj1Right) || (nPos3 >= obj1Left && nPos3 < obj1Right))))
        begin
            isObject = 1;
        end
        else if ( (((nPos4 >= obj2Top  && nPos4 < obj2Bottom) || (nPos5 >= obj2Top  && nPos5 < obj2Bottom)) && ((nPos6 >= obj2Left && nPos6 < obj2Right) || (nPos7 >= obj2Left && nPos7 < obj2Right))) || (((nPos0 >= obj2Top  && nPos0 < obj2Bottom) || (nPos1 >= obj2Top  && nPos1 < obj2Bottom)) && ((nPos2 >= obj2Left && nPos2 < obj2Right) || (nPos3 >= obj2Left && nPos3 < obj2Right))))
        begin
            isObject = 1;       
        end 
        else
        begin
            isObject = 0;
        end
    end
    
endmodule
