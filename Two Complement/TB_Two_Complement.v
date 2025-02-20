 module TB_Two_Complement();
   
   reg clk, n_reset, Data;
   wire Output;
   
   Two_Complement MyTB (.*); //AUTO PORT
   
   initial begin
    clk = 0;
    forever #10 clk = ~clk;
   end
   
   initial begin
     
     n_reset = 0;
     Data = 0;
     #100;
     @(posedge clk);
     #1; n_reset = 1;
     
     @(posedge clk);
     @(posedge clk);
     #1; Data = 1;
     
     
     @(posedge clk);
     @(posedge clk);
     #1; Data = 0;
     
     
     @(posedge clk);
     @(posedge clk);
     #1; Data = 1;
     
     
     @(posedge clk);
     #1; Data = 0;
     @(posedge clk);
     #1; Data = 1;
     
     @(posedge clk);
     @(posedge clk);
     $stop();
     
   end
   
   //DISPLAY
   always @(posedge clk) begin
     if (n_reset) 
       $monitor("TIME = %d; DATA = %b; OUT = %b", $time, Data, Output);
    end    
   
 endmodule