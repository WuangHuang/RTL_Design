`timescale 1ns / 1ps
module Traffic_Light_Controller (
    input clk, rst_n, main_sensor, side_sensor,
    output reg [2:0] main_road, 
    output reg [2:0] side_road, 
    output reg [4:0] counter, 
    output reg  main_turn_left,  side_turn_left
); 

typedef enum reg [1:0] {
    S0_MAIN_GREEN  = 2'b00,  
    S1_MAIN_YELLOW = 2'b01,  
    S2_SIDE_GREEN  = 2'b10,  
    S3_SIDE_YELLOW = 2'b11  
} state_t; 

state_t current_state, next_state;
reg  [4:0] timer; 

parameter RED = 3'b100, YELLOW = 3'b010, GREEN = 3'b001; 

always @(posedge clk or negedge rst_n)
begin 

    if (~rst_n) 
     begin
        current_state <= S0_MAIN_GREEN; 
        timer <= 5'd30; 
      end 
    else
     begin
     
       if (timer == 5'd0)
        begin
         if (current_state == S0_MAIN_GREEN)
          timer <= !main_sensor ? timer + 5'd5 : 5'd0;  
         if (current_state == S2_SIDE_GREEN)
          timer <= !side_sensor ? timer + 5'd5 : 5'd0;
        end  
        
         if (timer == 5'd0)
            begin     
             current_state = next_state;
              case (next_state)
               S0_MAIN_GREEN:  timer <=   5'd30  ; 
               S1_MAIN_YELLOW: timer <=   5'd3   ; 
               S2_SIDE_GREEN:  timer <=   5'd20  ; 
               S3_SIDE_YELLOW: timer <=   5'd3   ; 
              endcase
            end 
         else  timer <= timer - 1; 
     end   
      counter <= timer;
end 


  always @(*) 
  begin
    case (current_state)
        S0_MAIN_GREEN:  next_state = S1_MAIN_YELLOW; 
        S1_MAIN_YELLOW: next_state = S2_SIDE_GREEN;  
        S2_SIDE_GREEN:  next_state = S3_SIDE_YELLOW; 
        S3_SIDE_YELLOW: next_state = S0_MAIN_GREEN; 
        default:        next_state = S0_MAIN_GREEN;  
    endcase
  end 
   
  always @(*)
    begin
    case (current_state) 

     S0_MAIN_GREEN: 
      begin
           main_road <= GREEN; 
           side_road <= RED;  
           main_turn_left <= 0;  
           side_turn_left <= 1; 
      end   

     S1_MAIN_YELLOW: 
      begin
           main_road <= YELLOW; 
           side_road <= RED;  
           main_turn_left <= 0;  
           side_turn_left <= 1; 
      end   

     S2_SIDE_GREEN:  
      begin
           main_road <= RED; 
           side_road <= GREEN;  
           main_turn_left <= 1;  
           side_turn_left <= 0; 
      end   
       
     S3_SIDE_YELLOW:
       begin
           main_road <= RED; 
           side_road <= YELLOW;  
           main_turn_left <= 1;  
           side_turn_left  <=  0; 
      end  

    endcase
    end 

 endmodule
