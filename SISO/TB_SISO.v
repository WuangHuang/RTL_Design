`timescale 1ns / 1ps
    module TB_SISO(); 
      parameter DATA_WID   = 8;
      parameter MEMORY_WID = 5;
      
     reg clk;
     reg rst_n;
     reg  [DATA_WID - 1: 0] DataIn;
     wire [DATA_WID - 1: 0] DataOut;
     
     SISO DUT(
     .clk(clk),
     .rst_n(rst_n),
     .DataIn(DataIn),
     .DataOut(DataOut)
     );
     
     initial begin
        clk = 0;
        forever #10 clk = ~clk;
     end
     
     initial begin
     
      rst_n = 0;
      DataIn = 0;
      
      @(posedge clk);
      @(posedge clk);
      rst_n = 1;
      
      
      DataIn = $random;
      
      @(posedge clk);
      @(posedge clk);
      DataIn = $random;
      
      @(posedge clk);
      DataIn = $random;
      
      @(posedge clk);
      @(posedge clk);
       
     end
     
     always @(*) begin
      $monitor("TIME = %t, DATAiN = %d, DATAOUT = %d",$time, DataIn, DataOut);
     end
endmodule
