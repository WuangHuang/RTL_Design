module UART_Baud_Rate(
 input wire [2:0] baud_rate_select,
 output reg [17:0] CLK_PERS_BIT
 );
 always @(*)
    begin
     case (baud_rate_select)
       3'b000:	CLK_PERS_BIT = 18'b101000101100001011; //300 bsp(166_667)
       3'b001:	CLK_PERS_BIT = 18'b1010001011000011; //1200 bsp(41_667)
       3'b010:	CLK_PERS_BIT = 18'b101000101100001; //2400 bsp(20_833)
       3'b011:	CLK_PERS_BIT = 18'b10100010110001; //4800 bsp(10_417)
       3'b100:	CLK_PERS_BIT = 18'b1010001011000; //9600 bsp(5208)
       3'b101:	CLK_PERS_BIT = 18'b101000101100; //19200 bsp(2604)
       3'b110:	CLK_PERS_BIT = 18'b10100010110; //38400 bsp(1302)
       3'b111:	CLK_PERS_BIT = 18'b110110010; //115200 bsp(434)		
       default: CLK_PERS_BIT = 18'b110110010; //115200 bsp(434)
      endcase
    end	
endmodule
