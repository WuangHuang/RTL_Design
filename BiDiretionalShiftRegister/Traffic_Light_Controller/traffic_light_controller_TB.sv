`timescale 1ns / 1ps

module traffic_light_controller_TB;

    reg clk, rst_n, main_sensor, side_sensor;
    wire [2:0] main_road, side_road;
    wire [4:0] counter;
    wire main_turn_left, side_turn_left;
    
 
    traffic_light_controller uut (
        .clk(clk), 
        .rst_n(rst_n), 
        .main_sensor(main_sensor), 
        .side_sensor(side_sensor), 
        .main_road(main_road), 
        .side_road(side_road), 
        .counter(counter), 
        .main_turn_left(main_turn_left), 
        .side_turn_left(side_turn_left)
    );
    
      initial
         begin
            clk = 0;
            forever #10 clk = ~clk;
         end
         
    initial begin
   
        rst_n <= 0;
        #20 
        
        rst_n <= 1;
        main_sensor <= 1; 
        side_sensor <= 1;
        #10000
        
        main_sensor <= 1;
        side_sensor <= 0;
        #1000
        main_sensor <= 1; 
        side_sensor <= 1;
        
        main_sensor <= 0;
        side_sensor <= 1;
        #1000
        main_sensor <= 1; 
        side_sensor <= 1;
        
        $stop; 
    end
    

    always @(*) 
     begin
        $monitor("Time = %0t | State: %b | Main Road: %b | Side Road: %b | Counter: %d", 
                 $time, uut.current_state, main_road, side_road, counter);
     end
    
endmodule
