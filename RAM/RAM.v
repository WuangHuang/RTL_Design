module RAM (clk_write, address_write,
  data_write, write_enable,
  clk_read, address_read, data_read);
  
  parameter DATA_WID = 16;
  parameter ADDRESS_WID = 4;
  parameter ADDRESS_MAX = 16;

  input                      clk_write;
  input                      clk_read;
   
  input [ADDRESS_WID- 1 : 0] address_write;
  input [DATA_WID   - 1 : 0] data_write;
  input                      write_enable;

 
  input  [ADDRESS_WID - 1 : 0] address_read;
  output [DATA_WID    - 1 : 0] data_read;
  
  reg [DATA_WID - 1 : 0] data_read;
  reg [DATA_WID - 1 : 0] memory [ADDRESS_MAX-1:0];

  always @(posedge clk_write) begin
    if (write_enable) begin
      memory[address_write] <= data_write;
    end
  end

  always @(posedge clk_read) begin
    data_read <= memory[address_read];
  end

endmodule