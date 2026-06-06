`timescale 1ns / 1ps
`define IMEM_SIZE 4096

module instruction_mem_tb;

    reg  [63:0] addr;
    wire [31:0] instr;

    integer total_tests = 0;
    integer passed_tests = 0;

    instruction_mem uut (
        .addr(addr),
        .instr(instr)
    );

    initial begin
        $dumpfile("instruction_mem_tb.vcd");
        $dumpvars(0, instruction_mem_tb);

        #20; 

        total_tests = total_tests + 1;
        $display("Test 1: Read first instruction");

        addr = 0;
        #10;

        $display("Address = %h", addr);
        $display("Instruction = %h (Expected: %h)",
                 instr,
                 {uut.storage[0], uut.storage[1], uut.storage[2], uut.storage[3]});

        if (instr === {uut.storage[0], uut.storage[1], uut.storage[2], uut.storage[3]}) begin
            $display("Result: PASS\n");
            passed_tests = passed_tests + 1;
        end else begin
            $display("Result: FAIL\n");
        end

        total_tests = total_tests + 1;
        $display("Test 2: Read second instruction");

        addr = 4;
        #10;

        $display("Address = %h", addr);
        $display("Instruction = %h (Expected: %h)",
                 instr,
                 {uut.storage[4], uut.storage[5], uut.storage[6], uut.storage[7]});

        if (instr === {uut.storage[4], uut.storage[5], uut.storage[6], uut.storage[7]}) begin
            $display("Result: PASS\n");
            passed_tests = passed_tests + 1;
        end else begin
            $display("Result: FAIL\n");
        end

        total_tests = total_tests + 1;
        $display("Test 3: Boundary check (last valid instruction)");

        addr = `IMEM_SIZE - 4;
        #10;

        $display("Address = %h", addr);
        $display("Instruction = %h", instr);

        if (instr === {uut.storage[`IMEM_SIZE-4],
                       uut.storage[`IMEM_SIZE-3],
                       uut.storage[`IMEM_SIZE-2],
                       uut.storage[`IMEM_SIZE-1]}) begin
            $display("Result: PASS\n");
            passed_tests = passed_tests + 1;
        end else begin
            $display("Result: FAIL\n");
        end

        total_tests = total_tests + 1;
        $display("Test 4: Out-of-range address");

        addr = `IMEM_SIZE;
        #10;

        $display("Address = %h", addr);
        $display("Instruction = %h (Expected: 00000000)", instr);

        if (instr === 32'h00000000) begin
            $display("Result: PASS\n");
            passed_tests = passed_tests + 1;
        end else begin
            $display("Result: FAIL\n");
        end
        
        $display("=====================================");
        $display("Total Tests : %0d", total_tests);
        $display("Passed      : %0d", passed_tests);
        $display("Failed      : %0d", total_tests - passed_tests);
        $display("=====================================");

        $finish;
    end

endmodule