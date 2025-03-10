// 2025-3-10
// 二选一逻辑设计

`timescale 1ns/10ps

module fn_sw(
    a,
    b,
    sel,
    y
);
input a, b, sel;
output y;

// 用assign语句实现二选一逻辑
// assign y = sel ? (a ^ b) : (a & b);

// 用always语句块实现二选一逻辑
reg y;
always@(a or b or sel) begin
    if (sel == 1) begin
        y <= a ^ b;
    end
    else begin
        y <= a & b;
    end
end
endmodule

// --- testbench of fn_sw ---
module fn_sw_tb;
reg a, b, sel;
wire y;

fn_sw fn_sw(
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
);

initial begin
    // 指定 vvp 输出结果，不指定的话不会输出，切记
    $dumpfile("fn_sw.vcd");
    $dumpvars(0, fn_sw_tb);

    a <= 0; b <= 0; sel <= 0; 
    #10 a <= 0; b <= 0; sel <= 1; 
    #10 a <= 0; b <= 1; sel <= 0; 
    #10 a <= 0; b <= 1; sel <= 1; 
    #10 a <= 1; b <= 0; sel <= 0; 
    #10 a <= 1; b <= 0; sel <= 1; 
    #10 a <= 1; b <= 1; sel <= 0; 
    #10 a <= 1; b <= 1; sel <= 1;
    #10 $stop;
end
endmodule