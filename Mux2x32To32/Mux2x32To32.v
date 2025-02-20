  module mux2_1(Output, InputA, InputB, Select);

    output Output;
    input  InputA, InputB, Select;
    not  not1 (nSelect, Select);
    
    and  and1 (OuputA, InputA, nSelect); 
    and  and2 (OuputB, InputB,  Select);
    
    or   or2  (Output, OuputA, OuputB);

  endmodule
  
  
  // if Select = 0, DataOut = Data0
  // otherwise, DataOut = Data1
  module Mux2x32To32(DataOutput,DataA, DataB, Select);
    
    output [31:0] DataOutput;
    input  [31:0] DataA, DataB; 
    input         Select;

      mux2_1 Mux0  (DataOutput[0],  DataA[0],  DataB[0],  Select);
      mux2_1 Mux1  (DataOutput[1],  DataA[1],  DataB[1],  Select);
      mux2_1 Mux2  (DataOutput[2],  DataA[2],  DataB[2],  Select);
      mux2_1 Mux3  (DataOutput[3],  DataA[3],  DataB[3],  Select);
      mux2_1 Mux4  (DataOutput[4],  DataA[4],  DataB[4],  Select);
      mux2_1 Mux5  (DataOutput[5],  DataA[5],  DataB[5],  Select);
      mux2_1 Mux6  (DataOutput[6],  DataA[6],  DataB[6],  Select);
      mux2_1 Mux7  (DataOutput[7],  DataA[7],  DataB[7],  Select);
      mux2_1 Mux8  (DataOutput[8],  DataA[8],  DataB[8],  Select);
      mux2_1 Mux9  (DataOutput[9],  DataA[9],  DataB[9],  Select);
      mux2_1 Mux10 (DataOutput[10], DataA[10], DataB[10], Select);
      mux2_1 Mux11 (DataOutput[11], DataA[11], DataB[11], Select);
      mux2_1 Mux12 (DataOutput[12], DataA[12], DataB[12], Select);
      mux2_1 Mux13 (DataOutput[13], DataA[13], DataB[13], Select);
      mux2_1 Mux14 (DataOutput[14], DataA[14], DataB[14], Select);
      mux2_1 Mux15 (DataOutput[15], DataA[15], DataB[15], Select);
      mux2_1 Mux16 (DataOutput[16], DataA[16], DataB[16], Select);
      mux2_1 Mux17 (DataOutput[17], DataA[17], DataB[17], Select);
      mux2_1 Mux18 (DataOutput[18], DataA[18], DataB[18], Select);
      mux2_1 Mux19 (DataOutput[19], DataA[19], DataB[19], Select);
      mux2_1 Mux20 (DataOutput[20], DataA[20], DataB[20], Select);
      mux2_1 Mux21 (DataOutput[21], DataA[21], DataB[21], Select);
      mux2_1 Mux22 (DataOutput[22], DataA[22], DataB[22], Select);
      mux2_1 Mux23 (DataOutput[23], DataA[23], DataB[23], Select);
      mux2_1 Mux24 (DataOutput[24], DataA[24], DataB[24], Select);
      mux2_1 Mux25 (DataOutput[25], DataA[25], DataB[25], Select);
      mux2_1 Mux26 (DataOutput[26], DataA[26], DataB[26], Select);
      mux2_1 Mux27 (DataOutput[27], DataA[27], DataB[27], Select);
      mux2_1 Mux28 (DataOutput[28], DataA[28], DataB[28], Select);
      mux2_1 Mux29 (DataOutput[29], DataA[29], DataB[29], Select);
      mux2_1 Mux30 (DataOutput[30], DataA[30], DataB[30], Select);
      mux2_1 Mux31 (DataOutput[31], DataA[31], DataB[31], Select);

  endmodule


  