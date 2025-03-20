`timescale 1ns/1ps

    module FIFO(clk, rst_n, Write_EN, Read_EN, Data_IN, Data_OUT, Full, OverFlow, Empty, UnderFlow);
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 32;
    parameter FIFO_DEPTH = 1 << ADDR_WIDTH ; 
    
    input                         clk;
    input                         rst_n;   
    input                         Write_EN;  
    input                         Read_EN;  
    input       [DATA_WIDTH-1:0]  Data_IN;    
    output reg  [DATA_WIDTH-1:0]  Data_OUT;   
    output reg                    OverFlow;
    output reg                    UnderFlow; 
    output                        Full;   
    output                        Empty;   

    reg [DATA_WIDTH-1:0] FIFO_Memory [FIFO_DEPTH-1:0];
    reg [ADDR_WIDTH-1:0] Write_Pointer ;
    reg [ADDR_WIDTH-1:0] Read_Pointer ;
    reg [ADDR_WIDTH  :0] Count;


    assign Full  = (Count == FIFO_DEPTH);
    assign Empty = (Count == 0);

    always @(posedge clk) begin
        if (~rst_n) begin
            Write_Pointer    <= 0;
            Count            <= 0;
            OverFlow         <= 0;
        end else if (Write_EN) begin
            if (~Full) begin
                FIFO_Memory[Write_Pointer] <= Data_IN;
                Write_Pointer              <= Write_Pointer + 1;
                Count                      <= Count + 1;
                OverFlow                   <= 0; 
                UnderFlow                  <= 0;       
            end else begin
                OverFlow  <= 1; 
            end
        end
    end

    always @(posedge clk) begin
        if (~rst_n) begin
            Read_Pointer    <= 0;
            Data_OUT        <= 0;
            UnderFlow       <= 0;
        end else if (Read_EN) begin
            if (~Empty) begin
                Data_OUT     <= FIFO_Memory[Read_Pointer];
                Read_Pointer <= Read_Pointer + 1;
                Count        <= Count - 1;
                UnderFlow    <= 0; 
                OverFlow     <= 0; 
            end else begin
                UnderFlow    <= 1; 
            end
        end
    end
    
     always @(*) begin
     $monitor("DATA_IN = %d; DATA_OUT = %d; COUNT = %d, WRITE_POINTER = %d, REAd_POINTER = %d  FULL = %b; EMPTY = %b; OVERFLOW = %b; UNDERFLOW = %b",Data_IN, Data_OUT, Count, Write_Pointer, Read_Pointer, Full, Empty, OverFlow, UnderFlow);
     end

endmodule
