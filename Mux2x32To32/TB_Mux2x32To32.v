  module TB_Mux2x32To32();
    
    wire  [31:0] DataOutput;
    reg   [31:0] DataA, DataB; 
    reg          Select;

  
  Mux2x32To32 Mymodule(
    .DataOutput(DataOutput[31:0]),
    .DataA    (DataA      [31:0]),
    .DataB    (DataB      [31:0]),
    .Select   (Select)
  );
  
  initial
   begin
     
     DataA = -32'd1; DataB = 32'd0; Select = 1'b0;
      #100;
     DataA = -32'd1; DataB = 32'd0; Select = 1'b1;
      #100;
     
   end
   
  endmodule
  