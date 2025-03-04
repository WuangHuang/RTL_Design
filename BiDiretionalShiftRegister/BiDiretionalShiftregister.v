`timescale 1ns / 1ps
module BiDiretionalShiftRegister(Dir, Data, clk, rst_n, Out);
   parameter DATA_WID = 8;
    input Data;
    input clk, rst_n;
    input Dir;
    output reg [DATA_WID - 1: 0] Out;
    
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) 
          Out <= 0;
        else if (Dir)
         Out <= {Out[DATA_WID - 2: 0], Data};
        else
         Out <= {Data, Out[DATA_WID - 1: 1]};
    end
endmodule
