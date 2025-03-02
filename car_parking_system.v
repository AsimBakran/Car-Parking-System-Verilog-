module car_parking_system(
    input clk, reset,
    input sensor_entrance, sensor_out,
    input [2:0] password,
    output reg gate_state,
    output reg [2:0] led_state
);

    // State Encoding
    parameter IDLE            = 3'b000,
              WAIT_PASSWORD   = 3'b001,
              RIGHT_PASSWORD  = 3'b010,
              WRONG_PASSWORD  = 3'b011,
              STOP            = 3'b100;

    reg [2:0] current_state, next_state;
    
    //---------------------------------------------------------

    // State Transition (Sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    //---------------------------------------------------------
    

    //Leds block
    always@(posedge clk)
        begin
        gate_state <= 1'b0;    // Gate closed by default
        led_state <= 3'b000;   // Default LED off
        
            case (current_state)
            IDLE: begin
                if (sensor_entrance) begin
                    led_state <= 3'b001;
                    gate_state <= 1'b0; // Yellow LED
                end
                else begin
                    led_state <= 3'b000; // No activity
                    gate_state <= 1'b0;
                end
            end

            WAIT_PASSWORD: begin
                if (password == 3'b101) begin
                    led_state <= 3'b100; // Green LED
                    gate_state <= 1'b1;   // Open gate
                end
                else begin
                    led_state <= 3'b010; // Red LED
                    gate_state <= 1'b0;
                end
            end

            RIGHT_PASSWORD: begin
                gate_state <= 1'b1; // Gate remains open
                led_state <= 3'b100;

                if (sensor_entrance && sensor_out) begin
                    gate_state <= 1'b0; // Close gate
                end
                else if (~sensor_entrance && sensor_out) begin
                    gate_state <= 1'b0;
                end
                // Else, stay in RIGHT_PASSWORD
            end

            WRONG_PASSWORD: begin
                led_state <= 3'b010; // Red LED

                if (password == 3'b101) begin
                    led_state <= 3'b100;
                    gate_state <= 1'b1;
                end
                // Else, stay in WRONG_PASSWORD
            end

            STOP: 
                begin
                    led_state <= 3'b010; // Red LED
                    if (password == 3'b101) begin
                        led_state <= 3'b100;
                        gate_state <= 1'b1;
                end
            end
                // Else, stay in STOP
            default:
                begin
                    led_state <= 3'b000;
                    gate_state <= 1'b0;
                end
            
              endcase    
        end
        
        
        
    //combinational logic block    
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (sensor_entrance) begin
                    next_state = WAIT_PASSWORD;
      
                end
                else begin
                    next_state = IDLE;
                    
                end
            end

            WAIT_PASSWORD: begin
                if (password == 3'b101) begin
                    next_state = RIGHT_PASSWORD;
                end
                else begin
                    next_state = WRONG_PASSWORD;
                end
            end

            RIGHT_PASSWORD: begin

                if (sensor_entrance && sensor_out) begin
                    next_state = STOP;
                    
                end
                else if (~sensor_entrance && sensor_out) begin
                    next_state = IDLE;
                    
                end
                // Else, stay in RIGHT_PASSWORD
            end

            WRONG_PASSWORD: begin
                

                if (password == 3'b101) begin
                    next_state = RIGHT_PASSWORD;
                    
                end
                // Else, stay in WRONG_PASSWORD
            end

            STOP: begin
               
                if (password == 3'b101) begin
                    next_state = RIGHT_PASSWORD;
                    
                end
                // Else, stay in STOP
            end
        endcase
    end
endmodule