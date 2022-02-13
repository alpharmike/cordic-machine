`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:41:16 01/10/2022 
// Design Name: 
// Module Name:    cordic_single_stage 
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
module cordic_single_stage #(parameter m = 6, parameter n = 10, parameter iter_length = 4)(clk, x_in, y_in, z_in, i, atan, x_out, y_out, z_out);
	input clk;
	input signed [m + n - 1:0] x_in, y_in, z_in;
	input signed [m + n - 1:0] atan;
	input [iter_length - 1:0] i;
	output reg [m + n - 1:0] x_out, y_out, z_out;
	reg signed [1:0] d;	
	
	always @(posedge clk) begin
		d = z_in[m + n - 1] == 1'b0 ? 1 : -1;
		x_out = x_in - d * (y_in >>> i);
		y_out = y_in + d * (x_in >>> i);
		z_out = z_in - d * atan;
	end


endmodule
