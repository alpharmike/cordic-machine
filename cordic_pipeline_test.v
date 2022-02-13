`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:22:04 01/11/2022
// Design Name:   cordic_pipeline
// Module Name:   D:/Xilinx/Projects/CordicMachine/cordic_pipeline_test.v
// Project Name:  CordicMachine
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cordic_pipeline
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cordic_pipeline_test;

	// Inputs
	reg clk;
	reg [15:0] x0;
	reg [15:0] y0;
	reg [15:0] z0;

	// Outputs
	wire [15:0] out_x;
	wire [15:0] out_y;
	wire [15:0] out_z;

	// Instantiate the Unit Under Test (UUT)
	cordic_pipeline uut (
		.clk(clk), 
		.x0(x0), 
		.y0(y0), 
		.z0(z0), 
		.out_x(out_x), 
		.out_y(out_y), 
		.out_z(out_z)
	);

	always #20 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		x0 = 16'b000001_0000000000;
		y0 = 16'b0;
		z0 = 16'b000000_1100100100;

		// Wait 100 ns for global reset to finish
		#460;
		
		x0 = 16'b000001_0000000000;
		y0 = 16'b0;
		z0 = 16'b000001_1001001000;

		// Wait 100 ns for global reset to finish
		
		#460;
		
		x0 = 16'b000001_0000000000;
		y0 = 16'b000001_0000000000;
		z0 = 16'b000001_1001001000;

		// Wait 100 ns for global reset to finish
		// Add stimulus here

	end
      
endmodule

