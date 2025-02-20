 module Two_Complement(clk, n_reset, Data, Output);
    
   input  clk;
   input  n_reset;
   input  Data;
   output Output;
   
   wire clk;
   wire n_reset;
   wire Data;
   wire Output;
   
   reg  State;
   wire Next_State;
   
      
   parameter Q0 = 1'b0;
   parameter Q1 = 1'b1;
   
   
always @(posedge clk or negedge n_reset) begin
    if (!n_reset)
       State <= Q0;
    else
       State <= Next_State;
   end
    
    assign Next_State = (State == Q0) ? Data :  State;
    assign Output     = (State == Q0) ? Data : ~Data;
    
    
  endmodule