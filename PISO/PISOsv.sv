`timescale 1ns / 1ps

 module PISO(clk, rst_n, rSignal, wSignal, DataIn, DataOut);
  parameter DATA_WID = 8;
  parameter MEMORY_WID = 5;
    input clk;
    input rst_n;
    input rSignal;
    input wSignal;
    input      [DATA_WID-1: 0] DataIn [0: MEMORY_WID-1] ;
    output reg [DATA_WID-1: 0] DataOut;
    
    reg  [DATA_WID-1: 0] Memory  [0: MEMORY_WID-1] ;
    
    wire [1 : 0] Signal;
    assign Signal = {rSignal, wSignal};
    
    integer i; 
     always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
         for(i = 0; i < MEMORY_WID; i = i +1)
          Memory[i] <= 0;
         DataOut <= 0; end
        else  
          case (Signal)
           2'b00: begin
            for(i = 0; i < MEMORY_WID; i = i +1)
             Memory[i] <= Memory[i];
            DataOut <= 8'bx; end
           2'b01: begin
            Memory[0] <= 8'bx;
            for(i = 1; i < MEMORY_WID; i = i +1)
             Memory[i] <= Memory[i-1];
            DataOut <= Memory[MEMORY_WID - 1]; end
           2'b10: begin
            for(i = 0; i < MEMORY_WID; i = i +1)
             Memory[i] <= DataIn[i];
            DataOut <= 8'bx; end
           2'b11: begin
            for(i = 0; i < MEMORY_WID; i = i +1)
             Memory[i] <= DataIn[i];
            DataOut <= Memory[MEMORY_WID -1]; end
           default: begin
            for(i = 0; i < MEMORY_WID; i = i +1)
             Memory[i] <= 8'bx;
            DataOut <= 8'bx; end
          endcase 
     end 
  
endmodule
