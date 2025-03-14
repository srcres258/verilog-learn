// 2025-3-10
// 补码转换逻辑

`timescale 1ns/10ps

module comp_conv (
    a,
    a_comp
);
    input[7:0] a;
    output[7:0] a_comp;


    // wire[6:0] b; // 按位取反的幅度位；
    // wire[7:0] y; // 负数的补码；

    // assign b = ~a[6:0];
    // assign y[6:0] = b + 1; // 按位取反 + 1；
    // assign y[6:0] = ~a[6:0] + 1; // 按位取反 + 1；
    // assign y[7] = a[7]; // 符号位不变；
    // assign y = {a[7], ~a[6:0] + 1};

    assign a_comp = a[7] ? {a[7], ~a[6:0] + 1} : a; // 二选一；
endmodule

// --- testbench of comp_conv ---
module comp_conv_tb;
    reg[7:0] a_in;
    wire[7:0] y_out;

    comp_conv comp_conv(
        .a(a_in),
        .a_comp(y_out)
    );

    initial begin
        // 指定 vvp 输出结果，不指定的话不会输出，切记
        $dumpfile("comp_conv.vcd");
        $dumpvars(0, comp_conv_tb);

        a_in <= 0;
        #3000 $stop;
    end

    always #10 a_in <= a_in + 1;
endmodule