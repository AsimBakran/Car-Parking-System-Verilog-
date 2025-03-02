


#Car Parking System - Verilog Project#


Overview

This project implements a Car Parking System using Verilog. It simulates an automated parking gate that operates based on sensor inputs and a password verification mechanism. The system controls an entry gate and LED indicators to signal different states.


Features:

    Sensor-Based Entry Detection: Detects when a vehicle arrives at the entrance.
    Password Authentication: The gate opens only when the correct password (3'b101) is entered.
    LED Indicators:
        Red (3'b010): Wrong password or restricted access.
        Yellow (3'b001): Waiting for password input.
        Green (3'b100): Correct password, gate opens.
    Automated Gate Control: The gate opens when access is granted and closes when the vehicle exits.
    State Machine Implementation: The system transitions between different states like IDLE, WAIT_PASSWORD, RIGHT_PASSWORD, WRONG_PASSWORD, and STOP.

Files:

    car_parking_system.v – Verilog module implementing the parking system logic.
    car_parking_system_tb.v – Testbench for verifying functionality through simulation.
    README.md – This file describing the project.

How It Works:

    Idle State: The system waits for a vehicle to arrive at the entrance.
    Password Input: After detecting a vehicle, the system waits for a password.
    Authentication:
        If the password is correct, the gate opens (Green LED).
        If incorrect, the Red LED lights up, and the system stays in WRONG_PASSWORD until the correct password is entered.
    Vehicle Exit: Once the vehicle passes through, the gate closes automatically.

Simulation:

To test the system, run the car_parking_system_tb.v testbench in a Verilog simulator such as ModelSim, Xilinx Vivado, or Quartus. The testbench provides various input scenarios to verify the system's functionality.
Future Enhancements

    Implement automatic timeout if no password is entered within a certain time.
    Add multiple user access levels with different passwords.
    Integrate with an LCD display for user-friendly interactions.

Author

Designed and developed for educational and practical implementation of Verilog-based FSM (Finite State Machine) systems. 🚗🔒
