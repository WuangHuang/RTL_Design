module TB_Ring_counter();
  parameter DATA_WID = 4;
  
   reg clk,rst_n;
   wire [DATA_WID - 1: 0] Ring_Count;
   
   Ring_Counter MyTB(.*);
   
   initial begin
     clk = 1'b0;
     forever #20 clk = ~clk; 
   end
   
   initial begin
     rst_n = 1'b0;
      #20;
     @(negedge clk);
     rst_n = 1'b1;
   end
   
   always @(*) begin
    if (rst_n) 
     $monitor("TIME = %d; OUT = %b",$time,Ring_Count);
   end
   
endmodule