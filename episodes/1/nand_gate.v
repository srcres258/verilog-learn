// 2025-3-10 src_resources
// 与非门

`timescale 1ns/10ps

module nand_gate(
    A,
    B,
    Y
);
input A, B;
output Y;

assign Y = ~(A & B);
endmodule

// --- testbench of nand_gate ---
module nand_gate_tb;
reg aa, bb;
wire y;

nand_gate nand_gate(
    .A(aa),
    .B(bb),
    .Y(y)
);

initial begin
    // 指定 vvp 输出结果，不指定的话不会输出，切记
    $dumpfile("nand_gate.vcd");
    $dumpvars(0, nand_gate_tb);

    aa <= 0; bb <= 0;
    #10 aa <= 0; bb <= 1;
    #10 aa <= 1; bb <= 0;
    #10 aa <= 1; bb <= 1;
    #10 $stop;
end
endmodule