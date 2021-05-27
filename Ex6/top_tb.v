//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
	reg clk;
	reg [2:0] colour;
	reg [2:0] previous_colour;
	reg enable;
	reg err;
	reg test = 0;
	wire [23:0] rgb;

//Todo: Clock generation
	initial
    	begin
	   clk = 1'b0;
	   forever
		#(CLK_PERIOD/2) clk=~clk;
	end

//Colour generator
	initial begin
	   #(CLK_PERIOD/2)
	   colour = 3'b000;
	   forever begin		
		#CLK_PERIOD
		previous_colour = colour;
		colour = colour + 3'b001;
		#CLK_PERIOD
		previous_colour = colour;
		colour = colour + 3'b001;
		#CLK_PERIOD
		previous_colour = colour;
		colour = colour + 3'b001;
		#CLK_PERIOD
		previous_colour = colour;
		colour = colour + 3'b001;
		#CLK_PERIOD
		previous_colour = colour;
		colour = colour + 3'b001;
		#CLK_PERIOD
		previous_colour = colour;
		colour = colour + 3'b001;
		#CLK_PERIOD
		previous_colour = colour;
		colour = colour + 3'b001;
		#CLK_PERIOD
		previous_colour = colour;
		colour = 3'b000;
	   end
	end

//Enable generator
	initial begin
	   enable = 1'b0;
	   #(CLK_PERIOD/2)
	   forever begin
		#(CLK_PERIOD*8)
		#(CLK_PERIOD*3/4)
		enable = ~enable;
	   end
	end

//Todo: User logic
     initial begin
	err=0;
	#CLK_PERIOD
	forever begin
	   #CLK_PERIOD
	   test = ~test;
	   if(enable) begin
		case(previous_colour)
		   3'b000: if(rgb != 24'h000000) begin
			   $display("***TEST FAILED! rgb should be 0 when colour=000 rgb=%d ***", rgb);
			   err=1;	
			   end
		   3'b001: if(rgb != 24'h0000FF) begin
			   $display("***TEST FAILED! rgb should be 24'h0000FF when colour=001 rgb=%d ***", rgb);
			   err=1;	
			   end
		   3'b010: if(rgb != 24'h00FF00) begin
			   $display("***TEST FAILED! rgb should be 24'h00FF00 when colour=010 rgb=%d ***", rgb);
			   err=1;	
			   end
		   3'b011: if(rgb != 24'h00FFFF) begin
			   $display("***TEST FAILED! rgb should be 24'h00FFFF when colour=011 rgb=%d ***", rgb);
			   err=1;	
			   end
		   3'b100: if(rgb != 24'hFF0000) begin
			   $display("***TEST FAILED! rgb should be 24'hFF0000 when colour=100 rgb=%d ***", rgb);
			   err=1;	
			   end
		   3'b101: if(rgb != 24'hFF00FF) begin
			   $display("***TEST FAILED! rgb should be 24'hFF00FF when colour=101 rgb=%d ***", rgb);
			   err=1;	
			   end
		   3'b110: if(rgb != 24'hFFFF00) begin
			   $display("***TEST FAILED! rgb should be 24'hFFFF00 when colour=110 rgb=%d ***", rgb);
			   err=1;	
			   end
		   3'b111: if(rgb != 24'hFFFFFF) begin
			   $display("***TEST FAILED! rgb should be 24'hFFFFFF when colour=111 rgb=%d ***", rgb);
			   err=1;	
			   end
		endcase
	   end
	   else begin
		if(rgb != 24'h0) begin
		   $display("***TEST FAILED! rgb should be 0 when enable=0 rgb=%d ***", rgb);
		   err=1;
		end 
	   end		
        end
     end
   
//Todo: Finish test, check for success
	initial begin
        #160
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end

//Todo: Instantiate counter module
	rgb_module converter (
	.enable (enable),
	.clk (clk),
	.colour (colour),
	.rgb (rgb)
	);
 
endmodule
