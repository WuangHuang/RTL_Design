`timescale 1ns / 1ps

module TB_SIPO;

    parameter DATA_WID = 8;
    parameter MEMORY_WID = 4;

    reg clk;
    reg rst_n;
    reg [DATA_WID - 1 : 0] Data;

    wire [DATA_WID - 1 : 0] Signal [0 : MEMORY_WID - 1];

    SIPO #(.DATA_WID(DATA_WID),.MEMORY_WID(MEMORY_WID)) DUT (
        .clk(clk),
        .rst_n(rst_n),
        .Data(Data),
        .Signal(Signal)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk; 
    end

    initial begin

        #100;
        $stop;
    end

endmodule
