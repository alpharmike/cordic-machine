`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:52:53 01/11/2022
// Design Name:   cordic_single_stage
// Module Name:   D:/Xilinx/Projects/CordicMachine/cordic_single_stage_test.v
// Project Name:  CordicMachine
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cordic_single_stage
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cordic_single_stage_test;

	// Inputs
	reg clk;
	reg [15:0] x_in;
	reg [15:0] y_in;
	reg [15:0] z_in;
	reg [3:0] i;
	reg [15:0] atan;

	// Outputs
	wire [15:0] x_out;
	wire [15:0] y_out;
	wire [15:0] z_out;

	// Instantiate the Unit Under Test (UUT)
	cordic_single_stage uut (
		.clk(clk), 
		.x_in(x_in), 
		.y_in(y_in), 
		.z_in(z_in), 
		.i(i), 
		.atan(atan), 
		.x_out(x_out), 
		.y_out(y_out), 
		.z_out(z_out)
	);

	always #20 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		x_in = 16'b000001_0000000000;
		y_in = 16'b0;
		z_in = 16'b000000_1100100100; // pi / 4
		i = 0;
		atan = 16'b000000_1100100100;

		// Wait 100 ns for global reset to finish
		#40;
		
		// Initialize Inputs
		x_in = 16'b000001_0000000000;
		y_in = 16'b000001_0000000000;
		z_in = 16'b0;
		i = 1;
		atan = 16'b000000_0111011010;


		// Wait 100 ns for global reset to finish
		#40;
		
		// Initialize Inputs
		x_in = 16'b000000_1000000000;
		y_in = 16'b000001_1000000000;
		z_in = 16'b111111_1000100110;
		i = 2;
		atan = 16'b000000_0011111010;
		
		// Wait 100 ns for global reset to finish
		#40;
		
		// Initialize Inputs
		x_in = 16'b000000_0001110000000;
		y_in = 16'b000000_0010110000000;
		z_in = 16'b111111_1111100100000;
		i = 3;
		atan = 16'b000000_0001111111;
		
		// Wait 100 ns for global reset to finish
		#40;
		
		// Initialize Inputs
		x_in = 16'b000001_0010110000;
		y_in = 16'b000001_0010100000;
		z_in = 16'b000000_0000000101;
		i = 8;
		atan = 16'b000000_0000000111;
        
		// Add stimulus here

	end
      
endmodule

