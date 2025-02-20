`timescale 1ns / 1ps
 
 module SIPO(clk, rst_n, Data, Signal);
  parameter DATA_WID = 8;
  parameter MEMORY_WID = 4;
  
    input clk;
    input rst_n;
    input  [DATA_WID - 1 : 0] Data;
    output reg [DATA_WID - 1 : 0] Signal [0 : MEMORY_WID - 1];
    
    reg  [DATA_WID - 1 : 0] Memory [0 : MEMORY_WID - 1];
    reg  wSignal;
    
    integer i;
    always @(posedge clk or negedge rst_n)
     begin
      if (~rst_n || wSignal) begin
       for (i = 0; i < MEMORY_WID; i = i + 1)
        Memory[i] <= 8'b0;
       wSignal <= 1'b0; end
      else
       begin
       for (i = 1; i < MEMORY_WID; i = i + 1)
        Memory[i] <= Memory[i - 1];
       Memory[0] <= Data[0];
       if (Memory[MEMORY_WID - 1] != 8'b0)
        wSignal <= 1'b1;
       if (wSignal)
        for (i = 0; i < MEMORY_WID; i = i + 1)
         Signal[i] <= Memory[i];
       end      
        
    end
    
endmodule
