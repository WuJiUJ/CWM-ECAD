//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
	reg rst;
	reg clk;
	reg button;
	reg err;
	reg [2:0] current;
	wire [2:0] colour;

//Todo: Clock generation
	initial
    	begin
	   clk = 1'b0;
	   forever
		#(CLK_PERIOD/2) clk=~clk;
	end

//Todo: button generation
	initial
    	begin
	   button=0;
	   #(2*CLK_PERIOD) button=1;
	   forever	        
		#(CLK_PERIOD/2) button=~button;
	end

//Todo: User logic
     initial begin
	err=0;	
	rst=0;
	#CLK_PERIOD
	rst=1;
	#(CLK_PERIOD/2)
	rst=0;
	#(CLK_PERIOD/4)
	current = colour;
	forever begin
	   #(CLK_PERIOD/2)
	   case(current)
	      3'b000: if (colour != 3'b001) begin
		      $display("***TEST FAILED! LED value is not 001 after 000 when button is pressed, colour=%d, previous colour=%d ***", colour, current);
		      err=1;
		      end
	      3'b001: if (colour != 3'b010) begin
		      $display("***TEST FAILED! LED value is not 010 after 001 when button is pressed, colour=%d, previous colour=%d ***", colour, current);
		      err=1;
		      end
	      3'b010: if (colour != 3'b011) begin
		      $display("***TEST FAILED! LED value is not 011 after 010 when button is pressed, colour=%d, previous colour=%d ***", colour, current);
		      err=1;
		      end
	      3'b011: if (colour != 3'b100) begin
		      $display("***TEST FAILED! LED value is not 100 after 011 when button is pressed, colour=%d, previous colour=%d ***", colour, current);
		      err=1;
		      end
	      3'b100: if (colour != 3'b101) begin
		      $display("***TEST FAILED! LED value is not 101 after 100 when button is pressed, colour=%d, previous colour=%d ***", colour, current);
		      err=1;
		      end
	      3'b101: if (colour != 3'b110) begin
		      $display("***TEST FAILED! LED value is not 110 after 101 when button is pressed, colour=%d, previous colour=%d ***", colour, current);
		      err=1;
		      end
	      3'b110: if (colour != 3'b001) begin
		      $display("***TEST FAILED! LED value is not 001 after 110 when button is pressed, colour=%d, previous colour=%d ***", colour, current);
		      err=1;
		      end
	      3'b111: if (colour != 3'b001) begin
		      $display("***TEST FAILED! LED value is not 001 after 111 when button is pressed, colour=%d, previous colour=%d ***", colour, current);
		      err=1;
		      end
	   endcase
	   current = colour;
	   #(CLK_PERIOD/2)
	   if (current != colour) begin
	      $display("***TEST FAILED! LED value changed when button is released, colour=%d, previous colour=%d ***", colour, current);
	      err=1;
	      end
	   current = colour;
        end
     end
   
//Todo: Finish test, check for success
	initial begin
        #100
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end

//Todo: Instantiate counter module
	LED top (
	.rst (rst),
	.button (button),
	.clk (clk),
	.colour (colour)
	);
 
endmodule 
