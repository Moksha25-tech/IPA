`timescale 1ns / 1ps

module control_tb;

reg  [6:0] opcode;

wire Branch;
wire MemRead;
wire MemtoReg;
wire [1:0] ALUOp;
wire MemWrite;
wire ALUSrc;
wire RegWrite;

integer total = 0;
integer passed = 0;

// Instantiate DUT
control_unit uut (
    .opcode(opcode),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite)
);

task verify;
    input expBranch;
    input expMemRead;
    input expMemtoReg;
    input [1:0] expALUOp;
    input expMemWrite;
    input expALUSrc;
    input expRegWrite;
begin
    total = total + 1;

    if (Branch   == expBranch   &&
        MemRead  == expMemRead  &&
        MemtoReg == expMemtoReg &&
        ALUOp    == expALUOp    &&
        MemWrite == expMemWrite &&
        ALUSrc   == expALUSrc   &&
        RegWrite == expRegWrite) 
    begin
        passed = passed + 1;
        $display("Result : PASS\n");
    end
    else begin
        $display("Result : FAIL\n");
    end
end
endtask

initial begin

    $display("Test 1 : R-Type");
    opcode = 7'b0110011;
    #5;
    $display("Expected -> ALUOp=10, RegWrite=1");
    $display("Actual   -> ALUOp=%b, RegWrite=%b\n", ALUOp, RegWrite);
    verify(0,0,0,2'b10,0,0,1);

    $display("Test 2 : I-Type (addi)");
    opcode = 7'b0010011;
    #5;
    $display("Expected -> ALUOp=00, ALUSrc=1, RegWrite=1");
    $display("Actual   -> ALUOp=%b, ALUSrc=%b, RegWrite=%b\n",
              ALUOp, ALUSrc, RegWrite);
    verify(0,0,0,2'b00,0,1,1);

    $display("Test 3 : Load (ld)");
    opcode = 7'b0000011;
    #5;
    $display("Expected -> ALUOp=00, MemRead=1, MemtoReg=1");
    $display("Actual   -> ALUOp=%b, MemRead=%b, MemtoReg=%b\n",
              ALUOp, MemRead, MemtoReg);
    verify(0,1,1,2'b00,0,1,1);

    $display("Test 4 : Store (sd)");
    opcode = 7'b0100011;
    #5;
    $display("Expected -> ALUOp=00, MemWrite=1");
    $display("Actual   -> ALUOp=%b, MemWrite=%b\n",
              ALUOp, MemWrite);
    verify(0,0,0,2'b00,1,1,0);

    $display("Test 5 : Branch (beq)");
    opcode = 7'b1100011;
    #5;
    $display("Expected -> ALUOp=01, Branch=1");
    $display("Actual   -> ALUOp=%b, Branch=%b\n",
              ALUOp, Branch);
    verify(1,0,0,2'b01,0,0,0);

    $display("Test 6 : Undefined Opcode");
    opcode = 7'b1010101;
    #5;
    $display("Expected -> ALUOp=00, All control signals 0");
    $display("Actual   -> ALUOp=%b, Branch=%b, RegWrite=%b\n",
              ALUOp, Branch, RegWrite);
    verify(0,0,0,2'b00,0,0,0);

    $display("======================================");
    $display("Control Unit Verification Summary");
    $display("Total Cases : %0d", total);
    $display("Successful  : %0d", passed);
    $display("Unsuccessful: %0d", total - passed);
    $display("======================================");

    $finish;
end

endmodule