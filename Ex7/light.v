`timescale 1ns / 100ps

module light(
    //Todo: define inputs here
	input clk,
	input rst,
	input button,
	output reg [2:0] colour
    );
    
    //Todo: define registers and wires here

    //Todo: define your logic here  	
	always @(posedge clk) begin
	   if(rst)
	      colour = 3'b000;
	   else begin
	      if(button == 1'b1) begin
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
	      else begin
		case(colour)
			3'b000: colour = 3'b001;
			3'b111: colour = 3'b001;
			default: colour = colour;
	        endcase
	      end
	   end
	end             
      
endmodule
