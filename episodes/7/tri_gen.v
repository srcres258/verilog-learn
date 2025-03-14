// 2025-3-14
// 最简单的状态机，三角波发生器；

`timescale 1ns/10ps

module tri_gen (
    clk,
    res,
    d_out
);
    input clk, res;
    output[8:0] d_out;

    reg[1:0] state; // 主状态机寄存器；
    reg[8:0] d_out;

    reg[7:0] con; // 计数器，记录平顶周期个数；

    always @(posedge clk or negedge res) begin
        if (~res) begin
            state <= 0;
            d_out <= 0;
            con <= 0;
        end
        else begin
            case (state)
                0: // 上升；
                begin
                    d_out <= d_out + 1;
                    if (d_out == 299) begin
                        state <= 1;
                    end
                end
                1: // 平顶；
                begin
                    if (con == 200) begin
                        state <= 2;
                        con <= 0;
                    end
                    else begin
                        con <= con + 1;
                    end
                end
                2: // 下降；
                begin
                    d_out <= d_out - 1;
                    if (d_out == 1) begin
                        state <= 3;
                    end
                end
                3: // 平顶；
                begin
                    if (con == 200) begin
                        state <= 0;
                        con <= 0;
                    end
                    else begin
                        con <= con + 1;
                    end
                end
                default:
                begin
                    state <= 0;
                    con <= 0;
                    d_out <= 0;
                end
            endcase
        end
    end
endmodule

// --- testbench of tri_gen.v ---

module tri_gen_tb;
    reg clk, res;
    wire[8:0] d_out;

    tri_gen U1(
        .clk(clk),
        .res(res),
        .d_out(d_out)
    );

    initial begin
        // 指定 vvp 输出结果，不指定的话不会输出，切记
        $dumpfile("tri_gen.vcd");
        $dumpvars(0, tri_gen_tb);

        clk <= 0; res <= 0;
        #17 res <= 1;
        #40000 $stop;
    end

    always #5 clk <= ~clk;
endmodule