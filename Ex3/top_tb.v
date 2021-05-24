//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
	reg rst;
	reg change;
	reg on_off;
	reg clk;
	reg err;
	reg [7:0] current;
	wire [7:0] counter_out;

//Todo: Clock generation
	initial
    	begin
	   clk = 1'b0;
	   forever
		#(CLK_PERIOD/2) clk=~clk;
	end

//Todo: User logic
     initial begin
	err=0;	
	rst=1;
	change=0;
	on_off=1;
	forever begin
	   #(CLK_PERIOD)
	   current = counter_out;
	   if (counter_out != 8'b00000000)
	   begin
           $display("***TEST FAILED! did not reset counter to 0! when rst=%d, counter_out=%d ***",rst, counter_out);
           err=1;
           end
	   current = counter_out;
	   rst=0;
	   #(CLK_PERIOD)
	   if (counter_out != current)
	   begin
           $display("***TEST FAILED! did not remain the previous counter value! counter_out=%d ***",counter_out);
           err=1;
           end
	   current = counter_out;
	   change=1;	   
	   #(CLK_PERIOD)
	   if (counter_out != current + 8'b00000001)
	   begin
           $display("***TEST FAILED! did not step up counter by 1! counter_out=%d ***",counter_out);
           err=1;
           end
	   current = counter_out;
	   on_off=0;
	   #(CLK_PERIOD)
	   if (counter_out == current - 8'b00000001)
	   begin
           $display("***TEST FAILED! did not step down counter by 1! counter_out=%d ***",counter_out);
           err=1;
           end   
       end
     end
    
//Todo: Finish test, check for success
	initial begin
        #50 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end

//Todo: Instantiate counter module
	monitor top (
	.rst (rst),
	.change (change),
	.on_off (on_off),
	.clk (clk),
	.counter_out (counter_out)
	);
 
endmodule 
