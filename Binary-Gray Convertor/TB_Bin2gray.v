  module TB_Bin2Gray();
   parameter DATA_WID = 4;
   
   reg  [DATA_WID - 1: 0] Bin;
   wire [DATA_WID - 1: 0] Gray;
   integer                index;
   
   Bin2gray MyTB(.*);
   
   initial begin
     
    Bin = 4'b0000; #20;
    for (index = 0; index < 2**DATA_WID; index = index + 1)
     begin  Bin = Bin + 1; #10; end 
    $stop;  
   end
   
   always @(*)
    begin
     $monitor("TIME = %d, BIN = %b, GRAY = %b",$time,Bin,Gray);
    end
    
  endmodule
