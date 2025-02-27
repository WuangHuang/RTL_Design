`timescale 1ns / 1ps
    module BiDiretionalShiftRegisterTB();
         parameter DATA_WID = 8;           
            reg Data;                      
            reg clk, rst_n;                
            reg Dir;                       
            wire [DATA_WID - 1: 0] Out;
            
         BiDiretionalShiftRegister DUT(
         .Data(Data),
         .clk(clk),
         .rst_n(rst_n),
         .Dir(Dir),
         .Out(Out)
         );
         
         initial begin
            clk = 0;
            forever #10 clk = ~clk;
         end
         
         initial begin
         
            rst_n <= 0;
            #20
            
            rst_n <= 1;
            Data <= 1;
            
            repeat (7) @(posedge clk)
            Dir <= 1; 
            
            repeat (3) @(posedge clk)
            Dir <= 1; Data <= 0;
            
            repeat (5) @(posedge clk)
            Dir <= 0; Data <= 1;
            
            repeat (2) @(posedge clk)
            Dir <= 0; Data <= 0;
            
            $stop();
            
         end
         
         always @(*) begin
          $monitor("RST = %b, DATA = %b, DIR = %b, OUT = %b", rst_n, Data, Dir, Out);
         end
endmodule
