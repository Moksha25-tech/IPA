`timescale 1ns / 1ps

module alu_control_tb;

reg  [1:0] ALUOp;
reg  funct7_bit;
reg  [2:0] funct3;

wire [3:0] ALUControl;

integer total = 0;
integer passed = 0;

alu_control uut (
    .ALUOp(ALUOp),
    .funct7_bit(funct7_bit),
    .funct3(funct3),
    .ALUControl(ALUControl)
);

task verify;
    input [3:0] expected;
begin
    total = total + 1;

    if (ALUControl == expected) begin
        passed = passed + 1;
        $display("Expected = %b | Actual = %b | PASS\n", expected, ALUControl);
    end
    else begin
        $display("Expected = %b | Actual = %b | FAIL\n", expected, ALUControl);
    end
end
endtask

initial begin

    $display("====== Test 1 : ALUOp=00 (Load/Store/Addi) ======");
    ALUOp = 2'b00; funct3 = 3'b000; funct7_bit = 0;
    #5;
    verify(4'b0000); // ADD

    $display("====== Test 2 : ALUOp=01 (Branch) ======");
    ALUOp = 2'b01; funct3 = 3'b000; funct7_bit = 0;
    #5;
    verify(4'b1000); // SUB

    $display("====== Test 3 : R-Type ADD ======");
    ALUOp = 2'b10; funct3 = 3'b000; funct7_bit = 0;
    #5;
    verify(4'b0000); // ADD

    $display("====== Test 4 : R-Type SUB ======");
    ALUOp = 2'b10; funct3 = 3'b000; funct7_bit = 1;
    #5;
    verify(4'b1000); // SUB

    $display("====== Test 5 : R-Type AND ======");
    ALUOp = 2'b10; funct3 = 3'b111; funct7_bit = 0;
    #5;
    verify(4'b0111); // AND

    $display("====== Test 6 : R-Type OR ======");
    ALUOp = 2'b10; funct3 = 3'b110; funct7_bit = 0;
    #5;
    verify(4'b0110); // OR

    $display("====== Test 7 : Invalid funct3 ======");
    ALUOp = 2'b10; funct3 = 3'b101; funct7_bit = 0;
    #5;
    verify(4'b1111); // invalid case

    $display("====== Test 8 : Invalid ALUOp ======");
    ALUOp = 2'b11; funct3 = 3'b000; funct7_bit = 0;
    #5;
    verify(4'b1111); // invalid ALUOp

    $display("======================================");
    $display("ALU Control Verification Summary");
    $display("Total Cases : %0d", total);
    $display("Successful  : %0d", passed);
    $display("Unsuccessful: %0d", total - passed);
    $display("======================================");

    $finish;
end

endmodule