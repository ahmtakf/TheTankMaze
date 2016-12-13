`timescale 1ns / 1ps


module counterGenerator(
    input logic [9:0] hc,vc,
    input logic [2:0] direction,
    input logic [9:0] p0, p1, p2, p3, p4, p5, p6, p7,
    output logic [5:0] counterHL, counterHR, counterTL, counterTR
);
    
parameter Hh = 6;
parameter Hw = 4;
parameter Th = 28;
parameter Tw = 22;
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784;     // beginning of horizontal front porch
parameter vbp = 31;         // end of vertical back porch
parameter vfp = 511;     // beginning of vertical front porch

always_comb
begin                                
 
    if ( direction == 3'b000 || direction == 3'b010 || direction == 3'b100 || direction == 3'b110)
    begin
        counterHL = 0;
        counterHR = 0;
        counterTL = 0;
        counterTR = 0;                                   
    end
    else if ( direction == 3'b111 || direction == 3'b011)
    begin
        //Head turning
        if ( vc >= vbp + p4 && vc < vbp + p4 + Hh && hc >= hbp + p6 && hc < hbp + p6 + Hh)
        begin
            counterHL = Hh - vc + vbp + p4;
            counterHR = 0;
        end
        else if ( vc >= vbp + p4 && vc < vbp + p4 + Hw && hc >= hbp + p6 + Hh && hc < hbp + p7)
        begin
            counterHR = Hw - vc + vbp + p4;
            counterHL = 0;
        end
        else if ( vc >= vbp + p4 + Hh && vc < vbp + p5 && hc >= hbp + p6 && hc < hbp + p6 + Hw)
        begin
            counterHL = Hw - vbp - p5 + vc;
            counterHR = 0;
        end
        else if ( vc >= vbp + p4 + Hw && vc < vbp + p5 && hc >= hbp + p6 + Hw && hc < hbp + p7)
        begin
            counterHR = Hh - vbp - p5 + vc;
            counterHL = 0;
        end
        //Tank turning
        if ( vc >= vbp + p0 && vc < vbp + p0 + Th && hc >= hbp + p2 && hc < hbp + p2 + Th)
        begin
            counterTL = Th - vc + vbp + p0;
            counterTR = 0;
        end
        else if ( vc >= vbp + p0 && vc < vbp + p0 + Tw && hc >= hbp + p2 + Th && hc < hbp + p3)
        begin
            counterTR = Tw - vc + vbp + p0;
            counterTL = 0;
        end
        else if ( vc >= vbp + p0 + Th && vc < vbp + p1 && hc >= hbp + p2 && hc < hbp + p2 + Tw)
        begin
            counterTL = Tw - vbp - p1 + vc;
            counterTR = 0;
        end
        else if ( vc >= vbp + p0 + Tw && vc < vbp + p1 && hc >= hbp + p2 + Tw && hc < hbp + p3)
        begin
            counterTR = Th - vbp - p1 + vc;
            counterTL = 0;
        end
    end
    else if ( direction == 3'b001 || direction == 3'b101)
    begin
        //Head turning
        if ( vc >= vbp + p4 && vc < vbp + p4 + Hw && hc >= hbp + p6 && hc < hbp + p6 + Hw)
        begin
            counterHL = Hw - vc + vbp + p4;
            counterHR = 0;
        end
        else if ( vc >= vbp + p4 && vc < vbp + p4 + Hh && hc >= hbp + p6 + Hw && hc < hbp + p7)
        begin
            counterHR = Hh - vc + vbp + p4;
            counterHL = 0;
        end
        else if ( vc >= vbp + p4 + Hw && vc < vbp + p5 && hc >= hbp + p6 && hc < hbp + p6 + Hh)
        begin
            counterHL = Hh - vbp - p5 + vc;
            counterHR = 0;
        end
        else if ( vc >= vbp + p4 + Hh && vc < vbp + p5 && hc >= hbp + p6 + Hh && hc < hbp + p7)
        begin
            counterHR = Hw - vbp - p5 + vc;
            counterHL = 0;
        end
        //Tank turning
        if ( vc >= vbp + p0 && vc < vbp + p0 + Tw && hc >= hbp + p2 && hc < hbp + p2 + Tw)
        begin
            counterTL = Tw - vc + vbp + p0;
            counterTR = 0;
        end
        else if ( vc >= vbp + p0 && vc < vbp + p0 + Th && hc >= hbp + p2 + Tw && hc < hbp + p3)
        begin
            counterTR = Th - vc + vbp + p0;
            counterTL = 0;
        end
        else if ( vc >= vbp + p0 + Tw && vc < vbp + p1 && hc >= hbp + p2 && hc < hbp + p2 + Th)
        begin
            counterTL = Th - vbp - p1 + vc;
            counterTR = 0;
        end
        else if ( vc >= vbp + p0 + Th && vc < vbp + p1 && hc >= hbp + p2 + Th && hc < hbp + p3)
        begin
            counterTR = Tw - vbp - p1 + vc;
            counterTL = 0;
        end
    end
    else
    begin
        counterHL = 0;
        counterHR = 0;
        counterTL = 0;
        counterTR = 0; 
    end
end


endmodule
