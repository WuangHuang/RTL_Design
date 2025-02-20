`timescale 10ps/1ps
 
 module TB_Gray_Async_Counter();
   
   parameter DATA_WID = 4;
   
   reg                          clk;
   reg                          n_reset;
   wire      [DATA_WID - 1 : 0] Count; 
   
   
   Gray_Async_Counter MyTB(
   .clk(clk),
   .n_reset(n_reset),
   .Count(Count[DATA_WID - 1 : 0])
   );
   
   initial
   begin
     clk = 0;
     forever #10 clk = ~clk;
   end

    
   initial
    begin
     n_reset = 1'b0;
     #20;
     
     @(posedge clk);
     n_reset = 1'b1;
     
    end
  
     always @(*) begin
      $display("TIME = %d; COUNT = %b",$time,Count);
     end


    
  endmodule