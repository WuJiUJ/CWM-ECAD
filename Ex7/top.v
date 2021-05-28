//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module lightselector(
    //Todo: add ports 
	input sel,
	input clk,
	input rst,
	input button,
	output [23:0] light
    );
	wire [2:0] colour;
	wire [23:0] white = 24'hFFFFFF;
	wire [23:0] rgb;

	light low (
	  .clk(clk),
	  .rst(rst),
	  .button(button),
	  .colour(colour)
	);

    //IP core
	blk_mem_gen_0 top (
	  .clka(clk),    // input wire clka
	  .ena(~rst),      // input wire ena
	  .wea(1'b0),      // input wire [0 : 0] wea
	  .addra(colour),  // input wire [2 : 0] addra
	  .dina(24'h0),    // input wire [23 : 0] dina
	  .douta(rgb)  // output wire [23 : 0] douta
	);

	assign light = (sel == 1'b0) ? white : rgb;
endmodule
