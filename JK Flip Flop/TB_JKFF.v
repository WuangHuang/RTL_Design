`timescale 1ns / 1ps

module TB_JKFF();
    reg clk;
    reg rst_n;
    reg J;
    reg K;
    wire Q;
    
    JKFF DUT (
    .clk(clk),
    .rst_n(rst_n),
    .J(J),
    .K(K),
    .Q(Q)
    );
    
    initial begin
       clk = 0;
       forever #10 clk = ~clk;
    end
    
    initial begin
    
     rst_n = 0;
     
     @(posedge clk);
     @(posedge clk);
     rst_n = 1;
     J = 0; K = 0;
     
     @(posedge clk)
     J = 0; K = 1;
     
     @(posedge clk)
     @(posedge clk)
     J = 1; K = 0;
     
     @(posedge clk)
     J = 1; K = 1;
     
     @(posedge clk)
     J = $random(); K = 0;
     
     @(posedge clk)
     K = $random(); J = 0;
     
     @(posedge clk)
     J = $random(); K = $random();
     
     #20
     $stop();
     
    end
    
    always @(*) begin
     $monitor("TIME = %t, J = %b, K = %b, Q = %b",$time, J, K, Q);
    end
    
endmodule
