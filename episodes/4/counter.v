// 2025-3-11
// 计数器；

`timescale 1ns/10ps

module counter (
    clk,
    res,
    y
);
    input clk, res;
    output[7:0] y;

    reg[7:0] y;

    // wire[7:0] sum; // +1运算的结果；
    // assign sum = y + 1; // 组合逻辑部分；

    always @(posedge clk or posedge res) begin
        if (~res) begin
            y <= 0;
        end
        else begin
            // y <= sum;
            y <= y + 1;
        end
    end
endmodule

// --- testbench of counter ---
module counter_tb;
    reg clk, res;
    wire[7:0] y;
    counter counter(
        .clk(clk),
        .res(res),
        .y(y)
    );

    initial begin
        // 指定 vvp 输出结果，不指定的话不会输出，切记
        $dumpfile("counter.vcd");
        $dumpvars(0, counter_tb);

        clk <= 0; res <= 0;
        #17 res <= 1;
        #6000 $stop;
    end

    always #5 clk <= ~clk;
endmodule