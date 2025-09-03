//Broderick Bownds
// brbownds@hmc.edu
// 9/1/2025

`timescale 1ns/1ps

module lab1_test();
    logic clk, reset;
    logic [3:0] s;
    logic [2:0] led;
    logic [6:0] seg;
	logic [2:0] led_expected;

    logic [31:0] vectornum, errors;
    logic [13:0] testvectors[10000:0];  
    // 4-bit inputs + 2 expected outputs (led[0], led[1]) + 3 don't-care bits

    // Instantiate DUT
    lab1_bb dut(reset, s, led, seg);

    // Clock generator
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end

    // Initialize and load test vectors
    initial begin
        $readmemb("./lab12.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #22; 
		reset = 0;
    end

    // Apply test vectors
    always @(posedge clk) begin
        #1;
        {s, led_expected} = testvectors[vectornum][5:0]; 
    end

    // Check outputs
    always @(negedge clk) if (reset) begin
        if ({led[1], led[0]} !== led_expected[1:0]) begin
            $display("Error: input s=%b, led=%b (expected %b)", s, {led[1], led[0]}, led_expected[1:0]);
            errors = errors + 1;
        end
        vectornum = vectornum + 1;
        if (testvectors[vectornum] === 14'bx) begin
            $display("%d tests completed with %d errors", vectornum, errors);
            $stop;
        end
    end
endmodule


