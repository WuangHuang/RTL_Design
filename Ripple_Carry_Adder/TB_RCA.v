`timescale 1 ns / 1 ps 

 module TB_CLA_Adder();
   parameter DATA_WID = 64;
   
   
  reg                   CarryInput;
  reg  [DATA_WID - 1:0] InputA;
  reg  [DATA_WID - 1:0] InputB;
  
  wire                  CarryOutput;
  wire [DATA_WID - 1:0] Sum;  
  
  RCA Ripple_Carry_Adder(
         .Sum    (Sum   [DATA_WID - 1:0]),
         .InputA (InputA[DATA_WID - 1:0]),
         .InputB (InputB[DATA_WID - 1:0]),
         .CarryOutput (CarryOutput),
         .CarryInput  (CarryInput)
     );
     
   initial 
    begin : TestCase
      InputA = 1; InputB = 1 ; CarryInput = 1'b0;
       #100;
      InputA = -2; InputB = 1 ; CarryInput = 1'b0;
       #100;
      InputA = 7; InputB = 1 ; CarryInput = 1'b0;
       #100;  
    end
    
 endmodule 
