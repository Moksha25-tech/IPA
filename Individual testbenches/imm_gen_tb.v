`timescale 1ns/1ps

module imm_gen_tb;

reg  [31:0] instruction;
wire [63:0] imm_out;

integer total = 0;
integer pass  = 0;

// Instantiate DUT
imm_gen uut (
    .instruction(instruction),
    .imm_out(imm_out)
);

task check;
    input [63:0] expected;
    begin
        total = total + 1;

        if (imm_out === expected) begin
            pass = pass + 1;
            $display("Immediate = %0d | Expected = %0d  --> PASS\n",
                     imm_out, expected);
        end
        else begin
            $display("Immediate = %0d | Expected = %0d  --> FAIL\n",
                     imm_out, expected);
        end
    end
endtask

initial begin

    $display("Test 1 : I-Type (addi) Positive Immediate");
    // imm = 25
    instruction = {12'd25, 5'd1, 3'b000, 5'd2, 7'b0010011};
    #5;
    check(64'd25);

    $display("Test 2 : I-Type (addi) Negative Immediate");
    // imm = -16
    instruction = {12'b111111110000, 5'd1, 3'b000, 5'd2, 7'b0010011};
    #5;
    check(-64'd16);

    $display("Test 3 : S-Type (sd)");
    // imm = 40
    instruction = {
        7'd0,        // imm[11:5]
        5'd3,        // rs2
        5'd4,        // rs1
        3'b000,
        5'd8,        // imm[4:0]
        7'b0100011
    };
    #5;
    check(64'd8);   // 0<<5 + 8

    $display("Test 4 : B-Type (beq) Positive Offset");
    // offset = 16
    instruction = {
        1'b0,        // imm[12]
        6'b000000,   // imm[10:5]
        5'd1,
        5'd2,
        3'b000,
        4'b1000,     // imm[4:1]
        1'b0,        // imm[11]
        7'b1100011
    };
    #5;
    check(64'd16);

    $display("Test 5 : B-Type (beq) Negative Offset");
    // offset = -8
    instruction = {
        1'b1,        // imm[12]
        6'b111111,   // imm[10:5]
        5'd1,
        5'd2,
        3'b000,
        4'b1100,     // imm[4:1]
        1'b1,        // imm[11]
        7'b1100011
    };
    #5;
    check(-64'd8);

    $display("======================================");
    $display("Immediate Generator Verification");
    $display("Total Tests : %0d", total);
    $display("Passed      : %0d", pass);
    $display("Failed      : %0d", total-pass);
    $display("======================================");

    $finish;
end

endmodule