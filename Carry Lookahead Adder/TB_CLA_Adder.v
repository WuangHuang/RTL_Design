 module TB_CLA_Adder();
   parameter DATA_WID = 64;
   
   
  reg                   CarryInput;
  reg  [DATA_WID - 1:0] InputA;
  reg  [DATA_WID - 1:0] InputB;
  
  wire                  CarryOutput;
  wire [DATA_WID - 1:0] Sum;  
  
  CLA_Adder CLA(
         .Sum    (Sum   [DATA_WID - 1:0]),
         .InputA (InputA[DATA_WID - 1:0]),
         .InputB (InputB[DATA_WID - 1:0]),
         .CarryOutput (CarryOutput),
         .CarryInput  (CarryInput)
     );
     
   initial 
    begin : TestCase
      InputA = -64'd2;  InputB = 64'd1;  CarryInput = 1'b0;
       #100;
      InputA =  64'h18; InputB = 64'hC;  CarryInput = 1'b0;
       #100; 
      InputA =  64'b0;  InputB = 64'b10; CarryInput = 1'b0;
       #100;
    end
    
 endmodule 