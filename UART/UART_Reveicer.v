module UART_Receiver(
    input wire internal_clock,
    input wire RX_Enable,
    input wire RX_Data,
    input wire [17:0] CLK_PERS_BIT,
    output reg [7:0] Rx_Byte
);

  parameter s_IDLE         = 3'b000;
  parameter s_RX_START_BIT = 3'b001;
  parameter s_RX_DATA_BIT  = 3'b010;
  parameter s_RX_STOP_BIT  = 3'b011;
  parameter s_CLEANUP      = 3'b100;

  reg [7:0] buffer = 8'bxxxxxxxx;
  reg [2:0] Receiver_State = s_IDLE;
  reg [17:0] clock_counter = 0;
  reg [2:0] Receiver_Index_Bit = 3'b000;
 
  always @(posedge internal_clock) begin
    case (Receiver_State)

      s_IDLE: begin
        clock_counter <= 0;
        Receiver_Index_Bit <= 0;
        if (RX_Enable == 1'b0 && RX_Data == 1'b0) // start bit detected
          Receiver_State <= s_RX_START_BIT;
        else
          Receiver_State <= s_IDLE;
      end

      s_RX_START_BIT: begin 
        if (clock_counter < (CLK_PERS_BIT - 1) / 2) begin
         clock_counter <= clock_counter + 1; 
        end else begin 
          if (RX_Data == 1'b0) begin
            clock_counter <= 0;
            Receiver_Index_Bit <= 0;
            Receiver_State <= s_RX_DATA_BIT;
          end else begin
            Receiver_State <= s_IDLE;
          end
        end
      end

      s_RX_DATA_BIT: begin
        if (clock_counter < CLK_PERS_BIT - 1) begin
          clock_counter <= clock_counter + 1;
        end else begin
          clock_counter <= 0;
          buffer[Receiver_Index_Bit] <= RX_Data;
          if (Receiver_Index_Bit < 7) begin
            Receiver_Index_Bit <= Receiver_Index_Bit + 1;
          end else begin	
            Receiver_Index_Bit <= 0;
            Receiver_State <= s_RX_STOP_BIT;
          end
        end
      end

      s_RX_STOP_BIT: begin
        if (clock_counter < (CLK_PERS_BIT - 1) / 2) begin
          clock_counter <= clock_counter + 1;
        end else begin
          Rx_Byte = buffer;
          clock_counter <= 0;
          Receiver_Index_Bit <= 0;
          Receiver_State <= s_CLEANUP;
        end
      end

      s_CLEANUP: begin
        Receiver_State <= s_IDLE;
        Rx_Byte = 8'bx;	
        buffer <= 8'bx;
      end

      default: Receiver_State <= s_IDLE;
    endcase
  end

endmodule
