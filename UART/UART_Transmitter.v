module UART_Transmitter(
  input [7:0] Tx_Byte,
  input Tx_Enable,
  input internal_clock, 
  input wire [17:0] CLK_PERS_BIT,
  output reg Tx_Serial,
  output reg Tx_Done,
  output reg Tx_Active
);

  parameter s_IDLE         = 3'b000;
  parameter s_TX_START_BIT = 3'b001;
  parameter s_TX_DATA_BIT  = 3'b010;
  parameter s_TX_STOP_BIT  = 3'b011;
  parameter s_CLEANUP      = 3'b100;
  
  reg [2:0] Index_Bit;
  reg [2:0] Tx_State = s_IDLE;
  reg [7:0] Tx_Data;
  reg [17:0] clock_counter = 0;
  
    
  always @(posedge internal_clock) begin
    case (Tx_State)

      s_IDLE: begin
        clock_counter <= 0;
        Tx_Serial <= 1;
        Tx_Done   <= 0;
        Index_Bit <= 0;
        if (Tx_Enable == 1'b0) begin
          Tx_Active <= 1;
          Tx_Data <= Tx_Byte;
          Tx_State <= s_TX_START_BIT;
        end else
          Tx_State <= s_IDLE;
      end

      s_TX_START_BIT: begin 
        Tx_Serial <= 0; 
        if (clock_counter < CLK_PERS_BIT - 1) begin
          clock_counter <= clock_counter + 1; 
          Tx_State <= s_TX_START_BIT;
        end else begin 
          clock_counter <= 0;
          Tx_State <= s_TX_DATA_BIT;
        end 
      end

      s_TX_DATA_BIT: begin
        Tx_Serial <= Tx_Data[Index_Bit];
        if (clock_counter < (CLK_PERS_BIT - 1)) begin
          clock_counter <= clock_counter + 1;
          Tx_State <= s_TX_DATA_BIT;
        end else begin
          clock_counter <= 0;
          if (Index_Bit < 7) begin
            Index_Bit <= Index_Bit + 1;
            Tx_State <= s_TX_DATA_BIT;
          end else begin	
            Index_Bit <= 0;
            Tx_State <= s_TX_STOP_BIT;
          end
        end
      end

      s_TX_STOP_BIT: begin
        Tx_Serial <= 1; 
        if (clock_counter < CLK_PERS_BIT - 1) begin
          clock_counter <= clock_counter + 1;
          Tx_State <= s_TX_STOP_BIT;
        end else begin
          clock_counter <= 0;
          Tx_State <= s_CLEANUP;
        end
      end

      s_CLEANUP: begin
        Tx_State <= s_IDLE;
        Tx_Done <= 1'b1;
        Tx_Active <= 0;
      end
    
      default: Tx_State <= s_IDLE;
    endcase
  end
  
endmodule

