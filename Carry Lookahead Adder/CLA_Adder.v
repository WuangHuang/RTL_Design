 module CLA_Adder(InputA, InputB, CarryInput, Sum, CarryOutput);
    parameter DATA_WID = 64;
     
  input  [DATA_WID - 1:0] InputA;
  input  [DATA_WID - 1:0] InputB;
  input                   CarryInput;
  output [DATA_WID - 1:0] Sum;
  output                  CarryOutput;
  
  
  wire [DATA_WID - 1:0] Generate;
  wire [DATA_WID - 1:0] Propagate;
  wire [DATA_WID    :0] Carry_TMP;
  
  genvar j,i;
  generate 
     assign Carry_TMP[0] = CarryInput;
     
     for(j = 0; j <  DATA_WID; j = j + 1)
       begin: Carry_Generator 
         assign Generate[j]    = InputA[j] & InputB[j];
         assign Propagate[j]   = InputA[j] | InputB[j];
         assign Carry_TMP[j+1] = Generate[j] | Propagate[j] & Carry_TMP[j];
       end
      
      assign CarryOutput = Carry_TMP[DATA_WID];
      
      for(i = 0; i < DATA_WID; i = i + 1) begin: Sum_Without_Carry
       assign Sum[i] = InputA[i] ^ InputB[i] ^ Carry_TMP[i];  end
        
 endgenerate
endmodule  
       
    
  