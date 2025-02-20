`timescale 1ns / 1ps

 module TB_PISO();
  parameter DATA_WID = 8;
  parameter MEMORY_WID = 5;

  reg clk;
  reg rst_n;
  reg rSignal;
  reg wSignal;
  reg  [DATA_WID-1:0] DataIn [0:MEMORY_WID-1];
  wire [DATA_WID-1:0] DataOut;
  integer i;
  
  PISO #(.DATA_WID(DATA_WID), .MEMORY_WID(MEMORY_WID)) DUT (
    .clk(clk),
    .rst_n(rst_n),
    .rSignal(rSignal),
    .wSignal(wSignal),
    .DataIn (DataIn),
    .DataOut(DataOut)
  );

  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end

  initial begin
  
    rst_n = 0;
    rSignal = 0;
    wSignal = 0;
    
    for (i = 0; i < MEMORY_WID; i = i + 1) 
      DataIn[i] = $random;
    

    #10;
    rst_n = 1;


    @(posedge clk);
    @(posedge clk);
    rSignal = 0;
    wSignal = 0;

    @(posedge clk);
    rSignal = 1;
    wSignal = 1;
    
    @(posedge clk);
    rSignal = 0;
    wSignal = 1;
    
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    for (i = 0; i < MEMORY_WID; i = i + 1) 
      DataIn[i] = $random;
    rSignal = 1;
    wSignal = 0; 
    
    @(posedge clk);
    @(posedge clk);
    rSignal = 0;
    wSignal = 1;
    
    $finish;
  end

  always @(*) begin
    $monitor("Time=%t, rSignal=%b, wSignal=%b, DataOut=%h", $time,  rSignal, wSignal, DataOut);
  end
 
 endmodule


