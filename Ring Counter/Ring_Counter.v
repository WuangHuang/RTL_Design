 module Ring_Counter(rst_n, clk, Ring_Count);
   parameter DATA_WID = 4;
   
   input rst_n;
   input clk;
   output reg [DATA_WID - 1: 0] Ring_Count;
   
   wire RING_msb_buf;
   assign RING_msb_buf = (Ring_Count[DATA_WID - 1: 0] == 4'b0000) ? 1'b1 : Ring_Count[DATA_WID - 1] ;
   
   always @(posedge clk) begin
    if (~rst_n)
      Ring_Count <= 0;
    else
      Ring_Count[DATA_WID - 1:0] = {Ring_Count[DATA_WID - 2: 0], RING_msb_buf};
   end
   
 endmodule