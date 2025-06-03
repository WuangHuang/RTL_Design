`timescale 1ns / 1ps

module seven_segment_decoder_tb;
    reg [3:0] Binary_in;
    wire [6:0] Seg;

    seven_segment_decoder uut (
        .Binary_in(Binary_in),
        .Seg(Seg)
    );

    integer i;

    initial begin
        $display("Binary_in\tSeg");
        for (i = 0; i < 16; i = i + 1) begin
            Binary_in = i;
            #10;
            $display("%b \t %b", Binary_in, Seg);
        end

        $display("Testbench complete.");
        $stop();
    end

endmodule
