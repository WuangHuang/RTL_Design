`timescale 1ns / 1ps
module TFF(clk, rst_n, T, Q);

 input clk;
 input rst_n;
 input T;
 output reg Q;
 
 always @(posedge clk or negedge rst_n)
  begin
   if(~rst_n)
    Q <= 0;
   else if (T)
    Q <= ~Q;
   else 
    Q <= Q;
  end 
 
endmodule
