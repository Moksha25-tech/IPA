`timescale 1ns/1ps

module regfile_tb;

reg clk;
reg reset;
reg [4:0] read_reg1;
reg [4:0] read_reg2;
reg [4:0] write_reg;
reg [63:0] write_data;
reg reg_write_en;

wire [63:0] read_data1;
wire [63:0] read_data2;

integer total = 0;
integer pass = 0;

register_file uut (
    .clk(clk),
    .reset(reset),
    .read_reg1(read_reg1),
    .read_reg2(read_reg2),
    .write_reg(write_reg),
    .write_data(write_data),
    .reg_write_en(reg_write_en),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

// Clock
always #5 clk = ~clk;

task verify;
    input cond;
    begin
        total = total + 1;
        if (cond) begin
            pass = pass + 1;
            $display("Result: PASS\n");
        end
        else
            $display("Result: FAIL\n");
    end
endtask

initial begin
    clk = 0;
    reset = 1;
    reg_write_en = 0;

    #10 reset = 0;

    $display("Test 1: Reset verification (all registers zero)");
    read_reg1 = 5'd10;
    #5;
    $display("x10 = %h (Expected: 0000000000000000)", read_data1);
    verify(read_data1 == 64'd0);

    $display("Test 2: Write maximum positive 64-bit value to x5");
    write_reg = 5'd5;
    write_data = 64'h7FFFFFFFFFFFFFFF;
    reg_write_en = 1;
    #10;
    reg_write_en = 0;

    read_reg1 = 5'd5;
    #5;
    $display("x5 = %h (Expected: 7FFFFFFFFFFFFFFF)", read_data1);
    verify(read_data1 == 64'h7FFFFFFFFFFFFFFF);

    $display("Test 3: Write negative number to x8");
    write_reg = 5'd8;
    write_data = -64'd12345;
    reg_write_en = 1;
    #10;
    reg_write_en = 0;

    read_reg1 = 5'd8;
    #5;
    $display("x8 = %0d (Expected: -12345)", read_data1);
    verify(read_data1 == -64'd12345);

    $display("Test 4: Overwrite x5");
    write_reg = 5'd5;
    write_data = 64'h1111222233334444;
    reg_write_en = 1;
    #10;
    reg_write_en = 0;

    read_reg1 = 5'd5;
    #5;
    $display("x5 = %h (Expected: 1111222233334444)", read_data1);
    verify(read_data1 == 64'h1111222233334444);

    $display("Test 5: Simultaneous read of x5 and x8");
    read_reg1 = 5'd5;
    read_reg2 = 5'd8;
    #5;
    $display("x5 = %h", read_data1);
    $display("x8 = %0d", read_data2);
    verify((read_data1 == 64'h1111222233334444) &&
           (read_data2 == -64'd12345));


    $display("====================================");
    $display("Total Tests : %0d", total);
    $display("Passed         : %0d", pass);
    $display("Failed         : %0d", total-pass);
    $display("====================================");

    $finish;
end

endmodule