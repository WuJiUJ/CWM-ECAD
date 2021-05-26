//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module LED(
    //Todo: add ports 
	input clk,
	input rst,
	input button,
	output reg [2:0] colour
    );
                    
    //Todo: add registers and wires, if needed

    //Todo: add user logic
	
	always @(posedge rst or button) begin
	   if(rst)
	      colour = 3'b000;
	   else
	      case(colour)
	         3'b000: colour = 3'b001;
	         3'b001: colour = (button==1'b1) ? 3'b010 : 3'b001;
	         3'b010: colour = (button==1'b1) ? 3'b011 : 3'b010;
	         3'b011: colour = (button==1'b1) ? 3'b100 : 3'b011;
	         3'b100: colour = (button==1'b1) ? 3'b101 : 3'b100;
	         3'b101: colour = (button==1'b1) ? 3'b110 : 3'b101;
	         3'b110: colour = (button==1'b1) ? 3'b001 : 3'b110;
	         3'b111: colour = 3'b001;
	      endcase
	end
      
endmodule
