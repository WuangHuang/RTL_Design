`timescale 1ns / 1ps

module FrequencyDivider(clk, rst_n, clk_1Hz);
 input clk;
 input rst_n;
 output reg clk_1Hz;
 
 reg [25:0] Counter;
 
   always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            Counter <= 26'd0;
            clk_1Hz <= 1'b0; end 
        else 
         begin
            if (Counter == 26'd24999999) begin
                Counter <= 26'd0;
                clk_1Hz <= ~clk_1Hz;  end 
            else Counter <= Counter + 1;
         end
     end
    
    always @(*) begin
     $monitor(",TIME = %T, Counter = %d,clk_1Hz = %d",$time,Counter, clk_1Hz);
    end
    
 endmodule 