`timescale 1ns/1ps

module data_mem_tb;

reg clk;
reg reset;
reg [9:0] address;
reg [63:0] write_data;
reg MemRead;
reg MemWrite;

wire [63:0] read_data;

data_mem uut (
    .clk(clk),
    .reset(reset),
    .address(address),
    .write_data(write_data),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .read_data(read_data)
);

// Clock
always #5 clk = ~clk;

initial begin
    // Dump waveform
    $dumpfile("data_mem.vcd");
    $dumpvars(0, data_mem_tb);

    clk = 0;
    reset = 1;
    MemRead = 0;
    MemWrite = 0;
    address = 0;
    write_data = 0;

    #10 reset = 0;

    #10;
    address = 10;
    write_data = 64'h1122334455667788;
    MemWrite = 1;
    #10;
    MemWrite = 0;

    #10;
    MemRead = 1;
    #10;
    MemRead = 0;

    #10;
    address = 20;
    write_data = 64'hAABBCCDDEEFF0011;
    MemWrite = 1;
    #10;
    MemWrite = 0;

    #10;
    MemRead = 1;
    #10;
    MemRead = 0;

    #20;
    $finish;
end

endmodule