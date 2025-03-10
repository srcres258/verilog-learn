"""
本程序根据输入的各reg名称自动生成能用于Verilog testbench测试的真值表。
"""


DELAY = 10


if __name__ == '__main__':
    regs = input("请输入各reg名称，用空格分隔：").strip().split(' ')
    for v in range(2**len(regs)):
        bin_v = bin(v)[2:].zfill(len(regs))
        output = f"#{DELAY} "
        for i, reg in enumerate(regs):
            output += f"{reg} <= {bin_v[i]}; "
        print(output)
