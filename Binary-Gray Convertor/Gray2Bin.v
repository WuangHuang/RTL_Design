 module Gray2Bin(Bin, Gray);
   parameter DATA_WID = 4;
   input      [DATA_WID - 1: 0] Gray;
   output     [DATA_WID - 1: 0] Bin;
   
   genvar i;
   generate
     for(i = 0; i < DATA_WID; i = i + 1)
      assign Bin[i] = ^Gray[DATA_WID - 1: i];
   endgenerate
   
 endmodule 