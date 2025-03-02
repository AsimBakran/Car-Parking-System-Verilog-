`timescale 1ns / 1ps

module car_parking_system_tb;

    reg clk, reset;
    reg sensor_entrance, sensor_out;
    reg [2:0] password;
    wire gate_state;
    wire [2:0] led_state;
    
    // Instantiate the car parking system module
    car_parking_system uut (
        .clk(clk),
        .reset(reset),
        .sensor_entrance(sensor_entrance),
        .sensor_out(sensor_out),
        .password(password),
        .gate_state(gate_state),
        .led_state(led_state)
    );
    
    // Clock Generation
    always #5 clk = ~clk;
    
    // Test Sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        sensor_entrance = 0;
        sensor_out = 0;
        password = 3'b000;
        
        #10 reset = 0; // Release reset
        
        // Test Case 1: Car arrives at entrance
        #10 sensor_entrance = 1;
        #10 sensor_entrance = 0; // Wait for password input
        
        // Test Case 2: Wrong password entered
        #10 password = 3'b011;
        #10 password = 3'b000;
        
        // Test Case 3: Correct password entered
        #10 password = 3'b101;
        
        // Test Case 4: Car enters and then exits
        #10 sensor_entrance = 1;
        #10 sensor_out = 1;
        #10 sensor_entrance = 0;
        #10 sensor_out = 0;
        
        // Test Case 5: Car enters, wrong password, then corrects it
        #10 sensor_entrance = 1;
        #10 password = 3'b010; // Wrong password
        #10 password = 3'b101; // Correct password
        
        #20 $stop;
    end
endmodule
