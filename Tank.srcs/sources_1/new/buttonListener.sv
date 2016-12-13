`timescale 1ns / 1ps

module buttonListener(
    input logic clk,
    input logic [3:0] command,
    output logic bclk
    );

    logic[30:0] counter;
    logic temp;
    logic [30:0] d = 50000000;

    always @ ( posedge clk)
    begin
        if ( command > 4'b0000 && temp == 1)
        begin
            temp = 0;
            counter = 0;
        end
        if ( temp == 0)
        begin
            counter = counter + 1;
        end
        if ( counter == d)
        begin
            temp = 1;
        end
    end
    
    assign bclk = temp;

endmodule
