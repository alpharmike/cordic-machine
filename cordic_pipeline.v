`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:33:20 01/10/2022 
// Design Name: 
// Module Name:    cordic_pipeline 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module cordic_pipeline(clk, x0, y0, z0, out_x, out_y, out_z);
	parameter M = 6;
	parameter N = 10;
	parameter ITER_BIT = 4;
	parameter ITER_COUNT = 11;
	input clk;
	input signed [M + N - 1:0] x0;
	input signed [M + N - 1:0] y0;
	input signed [M + N - 1:0] z0;
	output signed [M + N - 1:0] out_x;
	output signed [M + N - 1:0] out_y;
	output signed [M + N - 1:0] out_z;
	
	reg signed [M + N - 1:0] atan_lut [ITER_COUNT:0];
	initial begin
		atan_lut[0] = 16'b0000001100100100;
		atan_lut[1] = 16'b0000000111011010;
		atan_lut[2] = 16'b0000000011111010;
		atan_lut[3] = 16'b0000000001111111;
		atan_lut[4] = 16'b0000000000111111;
		atan_lut[5] = 16'b0000000000011111;
		atan_lut[6] = 16'b0000000000001111;
		atan_lut[7] = 16'b0000000000000111;
		atan_lut[8] = 16'b0000000000000011;
		atan_lut[9] = 16'b0000000000000001;
		atan_lut[10] = 16'b0000000000000000;
		atan_lut[11] = 16'b0000000000000000;
	end
	
	wire signed [M + N - 1:0] x_values [ITER_COUNT:0];
	wire signed [M + N - 1:0] y_values [ITER_COUNT:0];
	wire signed [M + N - 1:0] z_values [ITER_COUNT:0];
		
	assign x_values[0] = x0;
	assign y_values[0] = y0;
	assign z_values[0] = z0;

	genvar i;
	
	generate

		for (i = 0; i < ITER_COUNT; i = i + 1)
			begin
				cordic_single_stage #(.m(M), .n(N), .iter_length(ITER_BIT)) stage (
					 .clk(clk), 
					 .x_in(x_values[i]), 
					 .y_in(y_values[i]), 
					 .z_in(z_values[i]), 
					 .i(i), 
					 .atan(atan_lut[i]), 
					 .x_out(x_values[i + 1]), 
					 .y_out(y_values[i + 1]), 
					 .z_out(z_values[i + 1])
				);

			end
	
	endgenerate

	assign out_x = x_values[ITER_COUNT];
	assign out_y = y_values[ITER_COUNT];
	assign out_z = z_values[ITER_COUNT];
endmodule
