// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

module SequentialMultiplier_tb;

  // Parameters
  localparam OPERAND_SIZE = 4;

  // Wires and registers
  reg clk;
  reg sreset;
  reg areset;
  reg [OPERAND_SIZE-1:0] A;
  reg [OPERAND_SIZE-1:0] B;
  wire [2*OPERAND_SIZE:0] Product;

  // Instantiate the module under test
  SequentialMultiplier #(OPERAND_SIZE) uut (
    .A(A),
    .B(B),
    .clk(clk),
    .sreset(sreset),
    .areset(areset),
    .Product(Product)
  );

  // Clock generator
  always begin
    #5 clk = ~clk;
  end

  // Test sequence
  initial begin
    // Initialize signals
    clk = 0;
    sreset = 1;
    areset = 1;
    A = 4'b0000; //0
    B = 4'b0101; //5

    // Apply reset
    #10 sreset = 0; areset = 0;
    #10 sreset = 1; areset = 1;
    #10 sreset = 0; areset = 0;
    #50;    
	
    A = 4'b0010; //2
    B = 4'b0011; //3

    // Apply reset
    #10 sreset = 0; areset = 0;
    #10 sreset = 1; areset = 1;
    #10 sreset = 0; areset = 0;
    #50;    

    A = 4'b0101; //5
    B = 4'b0101; //5

    // Apply reset
    #10 sreset = 0; areset = 0;
    #10 sreset = 1; areset = 1;
    #10 sreset = 0; areset = 0;
    #50;    
    
    A = 4'b1111; //0
    B = 4'b1111; //5

    // Apply reset
    #10 sreset = 0; areset = 0;
    #10 sreset = 1; areset = 1;
    #10 sreset = 0; areset = 0;
    #50;    
    
    
    // Open VCD dump
    $dumpfile("test.vcd");
    $dumpvars(0, SequentialMultiplier_tb);

    // Observe multiplication result
    #40 $display("Product = %b", Product);

    // End simulation
    #10 $finish;
  end

endmodule
