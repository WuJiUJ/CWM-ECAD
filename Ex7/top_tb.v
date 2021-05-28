//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex7 - Lights Selector
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
	reg clk;
	reg button;
	reg rst;
	reg err;
	reg sel;
	reg test = 0;
	wire [23:0] light;

//Todo: Clock generation
	initial
    	begin
	   clk <= 1'b0;
	   button <= 1'b0;
	   forever begin
		#(CLK_PERIOD/2)
		clk<=~clk;
		button<=~button;
	   end
	end

//Enable generator
	initial begin
	   sel = 1'b1;
	   #(CLK_PERIOD/2)
	   forever begin
		#(CLK_PERIOD*8)
		#(CLK_PERIOD*3/4)
		sel = ~sel;
	   end
	end

//Todo: User logic
     initial begin
	err=0;
	rst=0;
	#CLK_PERIOD
	forever begin
	   #CLK_PERIOD
	   test = ~test;
	     if(sel) begin		
		if(light != 24'h000000) begin
		   $display("***TEST FAILED! light should be 0 when colour=000 light=%d ***", light);
		   err=1;	
		   end
		if(light != 24'h0000FF) begin
		   $display("***TEST FAILED! light should be 24'h0000FF when colour=001 light=%d ***", light);
		   err=1;	
		   end
		if(light != 24'h00FF00) begin
		   $display("***TEST FAILED! light should be 24'h00FF00 when colour=010 light=%d ***", light);
		   err=1;	
		   end
		if(light != 24'h00FFFF) begin
		   $display("***TEST FAILED! rgb should be 24'h00FFFF when colour=011 light=%d ***", light);
		   err=1;	
		   end
		if(light != 24'hFF0000) begin
		   $display("***TEST FAILED! rgb should be 24'hFF0000 when colour=100 light=%d ***", light);
		   err=1;	
		   end
		if(light != 24'hFF00FF) begin
		   $display("***TEST FAILED! rgb should be 24'hFF00FF when colour=101 light=%d ***", light);
		   err=1;	
		   end
		if(light != 24'hFFFF00) begin
		   $display("***TEST FAILED! rgb should be 24'hFFFF00 when colour=110 light=%d ***", light);
		   err=1;	
		   end
		if(light != 24'hFFFFFF) begin
		   $display("***TEST FAILED! rgb should be 24'hFFFFFF when colour=111 light=%d ***", light);
		   err=1;	
		   end
	     end
	     else begin
		if(light != 24'hFFFFFF) begin
		   $display("***TEST FAILED! light should be 0 when sel=0 light=%d ***", light);
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
	lightselector selector (
	.button (button),
	.clk (clk),
	.rst (rst),
	.sel (sel),
	.light (light)
	);
 
endmodule
