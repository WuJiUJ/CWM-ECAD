`timescale 1ns / 100ps

module aircon(
    //Todo: add ports 
	input [4:0] temperature,
	input clk,
	output reg heating,
	output reg cooling
    );

    //Todo: add registers and wires, if needed
	reg [1:0] state = 2'b01;

    //Todo: add user logic
	always @(posedge clk) begin
	   case(state)
		2'b01: begin	
			if(temperature > 5'b10100) begin
				heating = 0;
				cooling = 1;
				state = state;
			end
			else begin
				heating = 0;
				cooling = 0;
				state = 2'b00;
			end
			end
		2'b00: begin 
			if(temperature >= 5'b10110) begin
				heating = 0;
				cooling = 1;
				state = 2'b01;
			end
			else if(temperature <= 5'b10010) begin
				heating = 1;
				cooling = 0;
				state = 2'b10;
			end
			else begin
				heating = 0;
				cooling = 0;
				state = state;
			end
			end
		2'b10: begin	
			if(temperature < 5'b10100) begin
				heating = 1;
				cooling = 0;
				state = state;
			end
			else begin
				heating = 0;
				cooling = 0;
				state = 2'b00;
			end
			end
	   endcase
	end
endmodule
