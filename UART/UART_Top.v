module UART_Top(
  
  //Baud Rate
  input wire internal_clock,
  input wire [2:0] baud_rate_select,
   
  // Transmitter signals
  input wire [7:0] Tx_Byte,
  input wire Tx_Enable,
  output wire Tx_Serial,
  output wire Tx_Done,
  output wire Tx_Active,

  // Receiver signals
  input wire RX_Enable,
  input wire RX_Data,
  output wire [7:0] Rx_Byte
  );
  
  wire [17:0] CLK_PERS_BIT;
  
  UART_Baud_Rate uut_baud_rate(
  .baud_rate_select(baud_rate_select),
  .CLK_PERS_BIT(CLK_PERS_BIT)
  );
  
  // UART transmitter instance
  UART_Transmitter uut_tx (
    .Tx_Byte(Tx_Byte),
    .Tx_Enable(Tx_Enable),
    .CLK_PERS_BIT(CLK_PERS_BIT),
    .internal_clock(internal_clock),
    .Tx_Serial(Tx_Serial),
    .Tx_Done(Tx_Done),
    .Tx_Active(Tx_Active)
  );

  // UART receiver instance
  UART_Receiver uut_rx (
    .internal_clock(internal_clock),
    .CLK_PERS_BIT(CLK_PERS_BIT),
    .RX_Enable(RX_Enable),
    .RX_Data(RX_Data),
    .Rx_Byte(Rx_Byte)
  );
  
endmodule
