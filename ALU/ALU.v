`timescale 1ns / 1ps
module ALU(A, B, ALU_Sel, ALU_Output);
 parameter DATA_WID = 4;
   input  [DATA_WID - 1 : 0] A,B;
   input  [3 : 0]            ALU_Sel;
   output [DATA_WID - 1 : 0] ALU_Output;
   
   reg    [DATA_WID - 1 : 0] ALU_Result;   
   assign ALU_Output = ALU_Result;
   
   always @(*) begin
    case (ALU_Sel)
        4'b0000:
         ALU_Result  = A + B;
        4'b0001:
         ALU_Result  = A - B;
        4'b0010:
         ALU_Result  = A * B;
        4'b0011:
         ALU_Result  = A / B;
        4'b0100:
          ALU_Result = A << 1;
        4'b0101:
          ALU_Result = A >> 1;
        4'b0110:
          ALU_Result = {A[DATA_WID - 2 : 0], A[DATA_WID - 1]};
        4'b0111:
          ALU_Result = {A[0], A[DATA_WID - 1 : 1]};
        4'b1000:
          ALU_Result =   A & B;
        4'b1001:
          ALU_Result =   A | B;
        4'b1010:
          ALU_Result =   A ^ B;
        4'b1011:
          ALU_Result = ~(A & B);
        4'b1100:
          ALU_Result = ~(A | B);
        4'b1101:
          ALU_Result = ~(A ^ B);
        4'b1110:
          ALU_Result =  (A >  B)? 4'd1 : 4'd0;
        4'b1111:
          ALU_Result =  (A == B)? 4'd1 : 4'd0;
        default : ALU_Result = A + B;
      endcase
   end
endmodule
