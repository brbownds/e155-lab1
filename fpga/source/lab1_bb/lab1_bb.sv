//Broderick Bownds
// brbownds@hmc.edu
// 9/1/2025

// This is our top module where we instantiate seven segment display

module lab1_bb( input  logic reset,
				input  logic [3:0] s,
				output logic [2:0] led,
				output logic [6:0] seg);	
				
		logic int_osc;  //clk
		logic [23:0] counter;
  
   // Internal high-speed oscillator, divides 48MHz into 24MHz because of 2'b01
   HSOSC #(.CLKHF_DIV(2'b01)) 
         hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
  
   // Counter
   always_ff @(posedge int_osc) begin
	   if (reset == 0) 
		   counter <=0; 
     else if(counter == 5000000) begin
		 counter <= 0; 
		 led[2] <= ~led[2];
		 end
     else           
		 counter <= counter + 1;
   end
   
 assign led[0] = s[0] ^ s[1];
 assign led[1] = s[2] & s[3];
// Make more meaningful names for integrating different modules
	seven_segdis sevenseg(s, seg);
  
endmodule
