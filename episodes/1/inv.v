// 2025-3-10 src_resources
// 反相器设计

`timescale 1ns/10ps

module inv(
    A,
    Y
);
input A;
output Y;

assign Y = ~A;
endmodule

// --- testbench of inv ---

module tb_inv;
reg aa;
wire yy;
inv inv(
    .A(aa),
    .Y(yy)
);

initial begin
    // 指定 vvp 输出结果，不指定的话不会输出，切记
    $dumpfile("inv.vcd");
    $dumpvars(0, tb_inv);

    aa <= 0;
    #10 aa <= 1;
    #10 aa <= 0;
    #10 aa <= 1;
    #10 $stop;
end
endmodule