`timescale 1ns / 1ps
module TB_Comparator_MUX();
    reg A,B;
    wire Lt, Gt, Eq;
    
    Comparator_MUX DUT (.A(A), . B(B), 
    .Lt(Lt), .Gt(Gt), .Eq(Eq));
    
    initial begin
      A = 0; B = 0; #10;
      A = 0; B = 1; #10;
      A = 1; B = 0; #10;
      A = 1; B = 1; #10;
      $finish();
    end
    
    always @(*) begin
     $monitor("TIME = %t, A = %b, B = %b, Eq = %b, Lt = %b, Gt = %b",$time, A , B, Eq, Lt, Gt);
    end
endmodule
