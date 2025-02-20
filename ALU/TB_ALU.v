`timescale 1ns / 1ps
 module TB_ALU;
  parameter DATA_WID = 4;
 
 reg  [DATA_WID - 1 : 0] A,B;
 wire [DATA_WID - 1 : 0] ALU_Output;
 reg  [3 : 0]            ALU_Sel;


    ALU test_unit(
       .A(A),
       .B(B),
       .ALU_Sel(ALU_Sel),
       .ALU_Output(ALU_Output)
     );
 
 integer i;
    initial begin
 
      A = $random();
      B = $urandom_range(10);
      
      ALU_Sel = 4'h0;
      for (i = 0; i <= 15; i = i + 1)
       begin
        #10; 
        ALU_Sel = ALU_Sel + 4'b01;  
       end
       $stop();
    end
  
  always @(*) begin
   $monitor("A = %b, B = %b, Sel = %b, Output = %b", A, B, ALU_Sel, ALU_Output);
  end
endmodule
