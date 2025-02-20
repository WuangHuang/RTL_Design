`timescale 1ns / 1ps

module JKFF(clk, rst_n, J, K, Q);   
    input clk;
    input rst_n;
    input J;
    input K;
    output reg Q;
    
    reg [1:0] JK;
    
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            Q <= 0;
        else begin
            JK = {J, K}; 
            case (JK)
                2'b00: Q <= Q; 
                2'b01: Q <= 0;
                2'b10: Q <= 1;
                2'b11: Q <= ~Q;
                default: Q <= 0; 
            endcase
        end
    end
endmodule
