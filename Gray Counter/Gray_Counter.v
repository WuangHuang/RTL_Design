module Gray_Async_Counter(clk, n_reset, Count);
  parameter DATA_WID = 4;
  
  input                        clk, n_reset;
  output reg [DATA_WID - 1: 0] Count;
  
  reg [DATA_WID - 1: 0] Q;
  integer i;
  
  always @(posedge clk) begin
    if (!n_reset) begin
     Q <= 1'b0; Count <= 1'b0; 
    end
    else begin
      
      Q <= Q + 1'b1;
      `ifdef FOR_LOOP
         for(i = 0; i < DATA_WID - 1; i = i + 1)
          Count[i] <= Q[i] ^ Q[i+1];
         Cout[DATA_WID - 1] <= Q[DATA_WID - 1];
      `else
         Count <= {Q[DATA_WID - 1], Q[DATA_WID - 1:1] ^ Q[DATA_WID - 2:0]};
      `endif
    end
  end
  
  
endmodule