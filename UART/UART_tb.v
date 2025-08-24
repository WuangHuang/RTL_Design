`timescale 1ns/1ps

module UART_tb;

  // Clock 50 MHz
  reg internal_clock = 0;
  always #10 internal_clock = ~internal_clock;

  // UART A
  reg [2:0] baud_rate_select_A;
  reg [7:0] Tx_Byte_A;
  reg Tx_Enable_A;
  wire Tx_Serial_A;
  wire Tx_Done_A;
  wire Tx_Active_A;

  reg RX_Enable_A;
  wire [7:0] Rx_Byte_A;

  // UART B
  reg [2:0] baud_rate_select_B;
  reg [7:0] Tx_Byte_B;
  reg Tx_Enable_B;
  wire Tx_Serial_B;
  wire Tx_Done_B;
  wire Tx_Active_B;
  reg RX_Enable_B;
  wire [7:0] Rx_Byte_B;

  // Instance UART A
  UART_Top uut_A (
    .internal_clock(internal_clock),
    .baud_rate_select(baud_rate_select_A),
    .Tx_Byte(Tx_Byte_A),
    .Tx_Enable(Tx_Enable_A),
    .Tx_Serial(Tx_Serial_A),
    .Tx_Done(Tx_Done_A),
    .Tx_Active(Tx_Active_A),
    .RX_Enable(RX_Enable_A),
    .RX_Data(Tx_Serial_B),  // RX(UART A) <- TX(UART B)
    .Rx_Byte(Rx_Byte_A)
  );

  // Instance UART B
  UART_Top uut_B (
    .internal_clock(internal_clock),
    .baud_rate_select(baud_rate_select_B),
    .Tx_Byte(Tx_Byte_B),
    .Tx_Enable(Tx_Enable_B),
    .Tx_Serial(Tx_Serial_B),
    .Tx_Done(Tx_Done_B),
    .Tx_Active(Tx_Active_B),
    .RX_Enable(RX_Enable_B),
    .RX_Data(Tx_Serial_A), // RX(UART B) <- TX(UART A)
    .Rx_Byte(Rx_Byte_B)
  );

  // Monitor signals
  initial begin
    $monitor("Time=%0t | A_Tx=%h | A_Rx=%h | A_TxEn=%b | A_TxDone=%b || B_Tx=%h | B_Rx=%h | B_TxEn=%b | B_TxDone=%b",
         $time, Tx_Byte_A, Rx_Byte_A, Tx_Enable_A, Tx_Done_A, Tx_Byte_B, Rx_Byte_B, Tx_Enable_B, Tx_Done_B); 
  end

  // Stimulus
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, UART_tb);

    // Setup
    baud_rate_select_A = 3'b100;  // 9600
    baud_rate_select_B = 3'b100;  // 9600
    RX_Enable_A = 1;
    RX_Enable_B = 1;
    Tx_Enable_A = 1;
    Tx_Enable_B = 1;
    Tx_Byte_A = 8'h00;
    Tx_Byte_B = 8'h00;

    #20; 	

    // UART A => UART B
    Tx_Byte_A = 8'hA5;
    RX_Enable_A = 1; RX_Enable_B = 0;
    Tx_Enable_A = 0; Tx_Enable_B = 1;
    @(posedge Tx_Done_A)
    #(20*434*10);

    // UART B => UART A
    Tx_Byte_B = 8'h3C;
    RX_Enable_B = 1; RX_Enable_A = 0;
    Tx_Enable_B = 0; Tx_Enable_A = 1;
    @(posedge Tx_Done_A)
    #(20*434*10);
    
    // UART B => UART A && UART A => UART B
    Tx_Byte_A = 8'hAA; Tx_Byte_B = 8'hBB;
    RX_Enable_B = 0; RX_Enable_A = 0;
    Tx_Enable_B = 0; Tx_Enable_A = 0;
    @(posedge Tx_Done_A)
    @(posedge Tx_Done_B)
    #(20*434*10);
    
    $finish;
  end

endmodule

