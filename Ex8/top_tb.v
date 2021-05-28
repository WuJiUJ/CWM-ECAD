//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8  - Simple End-to-End Design
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex8
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
	reg clk_p;
	wire clk_n;
	reg rst_n;
	reg [4:0] temperature;
	reg temperature_0;
	reg temperature_1;
	reg temperature_2;
	reg temperature_3;
	reg temperature_4;
	reg setTemp;
	reg err;
	wire heating;
	wire cooling;

//Todo: Clock generation
	initial
    	begin
	   clk_p = 1'b0;
	   forever begin
		#(CLK_PERIOD/2) 
		clk_p = ~clk_p
	   end
	   assign clk_n = ~clk_p;
	end

//Todo: User logic
     initial begin
	err=0;
	temperature=5'b10000;
	temperature_0=temperature[0];
	temperature_1=temperature[1];
	temperature_2=temperature[2];
	temperature_3=temperature[3];
	temperature_4=temperature[4];
	rst_n = 1;
	#(CLK_PERIOD*2)
	if(clk_n != 0) begin
	   $display("***TEST FAILED! clk_n should be 0 when rst_n=1! clk_n=%d***", clk_n);
	   err=1;
	end
	rst_n=0;
	forever begin
	   temperature_0<=temperature[0];
	   temperature_1<=temperature[1];
	   temperature_2<=temperature[2];
	   temperature_3<=temperature[3];
	   temperature_4<=temperature[4];
	   #CLK_PERIOD
	   if((heating & (temperature>=5'd10100))|(!heating & (temperature<=5'b10010))) begin
		$display("***TEST FAILED! heating should not be ON when temp>=20 or heating should not be OFF when temp<=18");
		err=1;
	   end
	   if((cooling & (temperature<=5'd10100))|(!cooling & (temperature>=5'b10110))) begin
		$display("***TEST FAILED! heating should not be ON when temp>=20 or heating should not be OFF when temp<=18");
		err=1;
	   end
	   #CLK_PERIOD
	   temperature = (cooling==1) ? temperature-1 : (heating==1) ? temperature+1 : temperature;
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
	top aircond (
	.temperature_0,
	.temperature_1,
	.temperature_2,
	.temperature_3,
	.temperature_4,
	.clk_n (clk_n),
	.clk_p (clk_p),
	.rst_n (rst_n),
	.heating (heating),
	.cooling (cooling)
	);
 
endmodule
