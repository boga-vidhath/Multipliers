module SequentialMultiplier #(parameter OPERAND_SIZE=4)(
        input [OPERAND_SIZE-1:0] A,B,
        input clk, sreset, areset,
        output logic [2*OPERAND_SIZE:0] Product
);

logic [OPERAND_SIZE-1:0] M;
logic [2*OPERAND_SIZE:0] CAQ;
logic stop;
logic [$clog2(OPERAND_SIZE)-1:0] counter;
always_ff@(posedge clk or posedge areset)
begin
    if (areset || sreset)
    begin
        counter <= 0;
        stop <= 0;
        M<=A;
        CAQ[2*OPERAND_SIZE]<=0;
        CAQ[2*OPERAND_SIZE-1:OPERAND_SIZE]<=0;
        CAQ[OPERAND_SIZE-1:0]<=B;
    end
    else if (!stop) 
    begin
        CAQ<=(CAQ[0]==1)?((CAQ+(M<<OPERAND_SIZE))>>1):(CAQ>>1);
        counter<=counter+1;
        if (counter == OPERAND_SIZE-1)
            stop <= 1;

    end
end

always_comb
begin
    Product = CAQ;
end
endmodule