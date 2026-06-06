`timescale 1ns / 1ps

module pc_tb;

    reg clk;
    reg reset;
    reg [63:0] pc_in;

    wire [63:0] pc_out;

    pc uut (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("pc_tb.vcd");
        $dumpvars(0, pc_tb);

        clk = 0;
        reset = 1;
        pc_in = 64'd0;

        #10;
        reset = 0;

        #10 pc_in = 64'd4;
        #10 pc_in = 64'd8;
        #10 pc_in = 64'd16;
        #10 pc_in = 64'd32;
        #10 pc_in = 64'd64;

        #10 reset = 1;
        #10 reset = 0;

        #20;

        $finish;
    end

endmodule