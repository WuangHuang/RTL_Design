`timescale 1ns / 1ps

module TB_JS_Counter();
 parameter DATA_WID = 8;
    reg clk;
    reg rst_n;
    wire [DATA_WID - 1 : 0] Data;
    
    JS_Counter #(.DATA_WID(DATA_WID)) DUT (
    .clk(clk),
    .rst_n(rst_n),
    .Data(Data)
    );
    
    initial begin clk = 0; forever #10 clk = ~ clk; end
    
    initial begin rst_n = 0; #20; rst_n = 1; $stop(); end
    
    always @(*) begin $monitor("TIME =  %t, DATA = %b", $time, Data);  end
    
    
endmodule
