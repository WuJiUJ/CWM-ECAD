//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex5 - Air Conditioning
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
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
	reg clk;
	reg [4:0] temp;
	reg [1:0] current;
	reg err;
	reg test = 0;
	wire heating;
	wire cooling;

//Todo: Clock generation
	initial
    	begin
	   clk = 1'b0;
	   forever
		#(CLK_PERIOD/2) clk=~clk;
	end

//Keep track of current state
	initial	begin
	   current = {cooling,heating};
	   forever begin
		#CLK_PERIOD
		current = {heating,cooling};
		if(current == 2'b11) begin
		   $display("***TEST FAILED! cooling and heating can not be ON at the same time! cooling=%d, heating=%d ***", cooling, heating);
		   err=1;
		end
	   end
	end

//Increase temp
	initial begin
	   temp = 5'b10001;
	   forever begin
		#CLK_PERIOD
		temp = temp + 5'b00001;
		#CLK_PERIOD
		temp = temp + 5'b00001;
		#CLK_PERIOD
		temp = temp + 5'b00001;
		#CLK_PERIOD
		temp = temp + 5'b00001;
		#CLK_PERIOD
		temp = temp + 5'b00001;
		#CLK_PERIOD
		temp = temp + 5'b00001;
		#CLK_PERIOD
		temp = temp + 5'b00001;
		#CLK_PERIOD
		temp = temp - 5'b00001;
		#CLK_PERIOD
		temp = temp - 5'b00001;
		#CLK_PERIOD
		temp = temp - 5'b00001;
		#CLK_PERIOD
		temp = temp - 5'b00001;
		#CLK_PERIOD
		temp = temp - 5'b00001;
		#CLK_PERIOD
		temp = temp - 5'b00001;
	   end
	end

//Todo: User logic
     initial begin
	err=0;
	#(3*CLK_PERIOD/4)
	forever begin
	   #CLK_PERIOD
	   test = ~test;
	   case(current)
		2'b00: if(temp >= 5'b10110 && cooling!=1) begin
			$display("***TEST FAILED! after idle state, cooling should be ON when temp >= 22! cooling=%d, heating=%d ***", cooling, heating);
			err=1;
			end
			else if(temp <= 5'b10010 && heating!=1) begin
			$display("***TEST FAILED! after idle state, heating should be ON when temp <= 18! cooling=%d, heating=%d ***", cooling, heating);
			err=1;
			end		
			else if(heating!=0 && cooling!=0) begin
			$display("***TEST FAILED! after idle state, it should remain in idle state when 18<temp<22! cooling=%d, heating=%d ***", cooling, heating);
			err=1;		
			end
		2'b01: if(temp > 5'b10100 && cooling!=1) begin
			$display("***TEST FAILED! after cooling state, cooling should be ON when 20<temp! cooling=%d, heating=%d ***", cooling, heating);
			err=1;
			end
			else if(temp <= 5'b10100 && cooling!=0) begin
			$display("***TEST FAILED! after cooling state, cooling should be OFF when temp<=20! cooling=%d, heating=%d ***", cooling, heating);
			err=1;
			end
		2'b10: if(temp < 5'b10100 && heating!=1) begin
			$display("***TEST FAILED! after heating state, heating should be ON when temp<20! cooling=%d, heating=%d ***", cooling, heating);
			err=1;
			end
			else if(temp >= 5'b10100 && heating!=0) begin
			$display("***TEST FAILED! after heating state, heating should be OFF when temp>=20! cooling=%d, heating=%d ***", cooling, heating);
			err=1;
			end
	   endcase
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
	aircon top (
	.temp (temp),
	.clk (clk),
	.heating (heating),
	.cooling (cooling)
	);
 
endmodule
