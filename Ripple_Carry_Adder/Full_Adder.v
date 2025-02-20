`timescale 1ns / 1ps

  module FA (InputA, InputB, CarryInput,Sum,CarryOutput);
   input   InputA,InputB,CarryInput;
   output  Sum,CarryOutput;
 
    assign Sum         = InputA ^ InputB ^ CarryInput;
    assign CarryOutput = (InputA & InputB) | (CarryInput & (InputA ^ InputB));
  
  endmodule