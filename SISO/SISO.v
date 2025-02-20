`timescale 1ns / 1ps
    module SISO(clk,rst_n, DataIn, DataOut);
      parameter DATA_WID   = 8;
      parameter MEMORY_WID = 5;
      
     input clk;
     input rst_n;
     input      [DATA_WID - 1: 0] DataIn;
     output reg [DATA_WID - 1: 0] DataOut;
     
     reg [MEMORY_WID - 1: 0] Memory [DATA_WID - 1: 0];
     
     integer i;
     integer j;
           
     always @(posedge clk or negedge rst_n) 
      begin
        if (~rst_n)
         begin
          for (i = 0; i < MEMORY_WID; i = i + 1)
           Memory[i] <= 0;
         end
        else    
         begin
          for (j = MEMORY_WID - 1; j > 0; j = j - 1)
           Memory[j] <= Memory[j - 1];
          Memory[0] = DataIn;        
          DataOut <= Memory[MEMORY_WID - 1];
         end
      end
     
endmodule
