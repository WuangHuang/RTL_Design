 module TB_Gray2Bin();
   parameter DATA_WID = 4;
   
   reg [DATA_WID - 1: 0] Gray;
   wire [DATA_WID - 1: 0] Bin;
   integer i;
   
   Gray2Bin MyTB(
   .Gray(Gray [DATA_WID - 1: 0]),
   .Bin (Bin  [DATA_WID - 1: 0])
   );
   
   initial begin
  
    Gray = 4'b0000; #20;
     
    for(i = 0; i < 2**DATA_WID; i = i + 1) begin: loop
      Gray = Gray + 1'b1;
       #20;
     end
     $stop();
   end
   
   always @(*) begin : Monitor
    $monitor("TIME = %d; GRAY = %b; BIN = %b", $time, Gray, Bin);
   end
   
 endmodule
