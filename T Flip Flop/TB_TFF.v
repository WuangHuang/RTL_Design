`timescale 1ns / 1ps
module TB_TFF();
    reg clk;
    reg rst_n;
    reg T;
    wire Q;
    
    TFF DUT(
    .clk(clk),
    .rst_n(rst_n),
    .T(T),
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
        T = 0;
        
        @(posedge clk);
        @(posedge clk);
        T = 1;
        
        @(posedge clk);
        @(posedge clk);
        T = 0;
        
        @(posedge clk);
        T = 1;
        
        @(posedge clk);
        @(posedge clk);
        T = 0;
             
        #20;
        $stop(); 
    end
    
      always @(*) begin
        $monitor("TIME = %t, T = %b, Q = %b",$time,T,Q);
      end
    
endmodule
