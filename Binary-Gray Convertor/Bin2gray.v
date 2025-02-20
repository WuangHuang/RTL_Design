module Bin2gray(Bin, Gray);
   parameter DATA_WID = 4;
   input  [DATA_WID - 1: 0] Bin;
   output [DATA_WID - 1: 0] Gray;
   
   genvar i;
   generate
     for(i = 0; i < DATA_WID - 1; i = i + 1)
      assign Gray[i] = ^Bin[i+ 1: i] ;
     assign Gray[DATA_WID - 1] = Bin[DATA_WID - 1];
   endgenerate

 endmodule