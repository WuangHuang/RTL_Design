`timescale 1ns/1ps

module TB_FIFO;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 5;
    parameter FIFO_DEPTH = 1 << ADDR_WIDTH;

    reg                   clk;
    reg                   rst_n;
    reg                   Write_EN;
    reg                   Read_EN;
    reg  [DATA_WIDTH-1:0] Data_IN;
    wire [DATA_WIDTH-1:0] Data_OUT;
    wire                  Full;
    wire                  OverFlow;
    wire                  Empty;
    wire                  UnderFlow;

    FIFO #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) 
     DUT (
        .clk(clk),
        .rst_n(rst_n),
        .Write_EN(Write_EN),
        .Read_EN(Read_EN),
        .Data_IN(Data_IN),
        .Data_OUT(Data_OUT),
        .Full(Full),
        .OverFlow(OverFlow),
        .Empty(Empty),
        .UnderFlow(UnderFlow)
     );

   initial begin 
    clk = 0;
    forever #10 clk = ~clk;
   end

    initial begin
      
        rst_n = 0;
        Write_EN = 0;
        Read_EN = 0;
        Data_IN = 0;

     
        #20
         rst_n = 1;


       //Check Full Signal
        repeat (FIFO_DEPTH) begin
            @ (posedge clk);
            Write_EN = 1;
            Data_IN = Data_IN + 1;
        end
        Write_EN = 0;

       
       //Check Overflow Signal
        @ (posedge clk);
        @ (posedge clk);
        Write_EN = 1;
        Data_IN = 255;
        @ (posedge clk);
        @ (posedge clk);
        #10 Write_EN = 0;

       
        //Check Data_OUT and Empty Signal
        repeat (FIFO_DEPTH) begin
            @ (posedge clk);
            Read_EN = 1;
        end
        #10 Read_EN = 0;

       
        //Check Underflow
        @ (posedge clk);
        @ (posedge clk);
        Read_EN = 1;
        #10 Read_EN = 0;
        
        #20 $finish;
    end
    
   
endmodule