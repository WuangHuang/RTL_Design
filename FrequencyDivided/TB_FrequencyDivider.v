`timescale 1ns / 1ps

module TB_FrequencyDivider();

    reg clk;
    reg rst_n;
    wire clk_1Hz;

 
    FrequencyDivider DUT (
        .clk(clk),
        .rst_n(rst_n),
        .clk_1Hz(clk_1Hz)
    );


    initial begin
        clk = 0;
        forever #10 clk = ~clk;  
    end

    initial begin
 
        rst_n = 0;
        #10
        rst_n = 1;
        
    end
    
    
endmodule



