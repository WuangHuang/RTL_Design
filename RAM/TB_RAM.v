// Testbench
module test;

  reg        clk_write;
  reg  [4:0] address_write;
  reg  [7:0] data_write;
  reg        write_enable;
  reg        clk_read;
  reg  [4:0] address_read;
  wire [7:0] data_read;
  
  // Instantiate design under test
  // D_WIDTH = 8
  // A_WIDTH = 5
  // A_MAX = 2^A_WIDTH = 32
  RAM #(8, 5, 32) TB_RAM (
    .clk_write(clk_write),
    .address_write(address_write),
    .data_write(data_write),
    .write_enable(write_enable),
    .clk_read(clk_read),
    .address_read(address_read),
    .data_read(data_read));
    
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1, test);
    
    clk_write = 0;
    clk_read = 0;
    write_enable = 0;
    address_read = 5'h1B;
    address_write = address_read;

    $display("Read initial data.");
    toggle_clk_read;
    $display("data[%0h]: %0h",
      address_read, data_read);
    
    $display("Write new data.");
    write_enable = 1;
    data_write = 8'hC5;
    toggle_clk_write;
    write_enable = 0;
    
    $display("Read new data.");
    toggle_clk_read;
    $display("data[%0h]: %0h",
      address_read, data_read);
  end
  
  task toggle_clk_write;
    begin
      #10 clk_write = ~clk_write;
      #10 clk_write = ~clk_write;
    end
  endtask

  task toggle_clk_read;
    begin
      #10 clk_read = ~clk_read;
      #10 clk_read = ~clk_read;
    end
  endtask

endmodule