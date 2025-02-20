`timescale 1ns / 1ps
module Comparator_MUX(A, B, Eq, Lt, Gt);
 input A, B;
 output Eq, Gt, Lt;
 
 Mux_4x1 M1 (.Signal(4'b1001), .Sel({A, B}), .Out(Eq));
 Mux_4x1 M2 (.Signal(4'b0010), .Sel({A, B}), .Out(Lt));
 Mux_4x1 M3 (.Signal(4'b0100), .Sel({A, B}), .Out(Gt));
 
endmodule

module Mux_4x1(Signal, Sel, Out);
   input [3 : 0] Signal;
   input [1 : 0] Sel;
   output reg    Out;
   
   always @(*) begin
    case (Sel)
     2'b00 : Out = Signal[0];
     2'b01 : Out = Signal[1];
     2'b10 : Out = Signal[2];
     2'b11 : Out = Signal[3];
     endcase
    end
 endmodule 