`timescale 1ns / 1ps

 module RCA(InputA, InputB, CarryInput, Sum, CarryOutput);
   parameter DATA_WID = 64;
   
    input  [DATA_WID - 1:0] InputA;
    input  [DATA_WID - 1:0] InputB;
    input                   CarryInput;
    output [DATA_WID - 1:0] Sum; 
    output                  CarryOutput;
                          
    wire   [DATA_WID - 1:0]  Carry_TMP;
      
     FA RCB_HA(
       .InputA      (InputA    [0]),
       .InputB      (InputB    [0]),
       .CarryInput  (CarryInput),
           
       .Sum         (Sum       [0]),
       .CarryOutput (Carry_TMP [0])
       );  
      
     genvar i;
      generate   
        for(i = 1; i < DATA_WID; i = i + 1)
         FA RCB_FA(
          .InputA      (InputA    [i]),
          .InputB      (InputB    [i]),
          .CarryInput  (Carry_TMP [i - 1]),
           
          .Sum         (Sum       [i]),
          .CarryOutput (Carry_TMP [i])
         );  
        assign CarryOutput = Carry_TMP[DATA_WID - 1];
      endgenerate
  
endmodule