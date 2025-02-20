`timescale 1ns / 1ps

module JS_Counter(clk, rst_n, Data);
 parameter DATA_WID = 8;
   input  clk;
   input  rst_n;
   output reg [DATA_WID - 1: 0]Data;
   
   wire JS_msb_inv;
   assign JS_msb_inv = ~Data[DATA_WID - 1];
   
   always @(posedge clk or negedge rst_n)
    begin
     if (~rst_n) 
      Data <= 0;
     else
       Data[DATA_WID - 1: 0] = {Data[DATA_WID - 2: 0],JS_msb_inv};
    end
 endmodule

