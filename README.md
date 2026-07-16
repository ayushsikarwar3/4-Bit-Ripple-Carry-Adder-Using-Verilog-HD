# Abstract
The 4-bit Ripple Carry Adder (RCA) is one of the most basic arithmetic circuits known in Digital Electronics. It adds two 4-bit binary numbers, by cascading four 1-bit FAs. The carry after each Full Adder is taken to the next stage which is a ripple effect. In this project, the design, simulation, verification and FPGA implementation of 4 bit Ripple Carry Adder Using Verilog HDL are shown. This design is simulated to validate it and can be synthesized on FPGA development boards using the industry standard Electronic Design Automation (EDA) tools like AMD Vivado or Intel Quartus Prime. In this project, the students will learn digital arithmetic, carry propagation and HDL design methodology.

# Keywords
- Ripple Carry Adder
- Full Adder
- Verilog HDL
- FPGA
- Digital Electronics
- Binary Addition
- RTL Design
- Combinational Circuit
- Introduction

# Objectives
- Implement 4 bit Ripple Carry Adder in Verilog HDL.
- Learn about how Full Adders work.
- Add two numbers using combinational circuits.
- Use HDL simulation tools to simulate the design.
- Test the circuit with various tests to check its validity.
- Formulate the design to be implemented on FPGA.
- Examine propogation delay for a carry.

 # Problem Statement
Using Verilog HDL, design and implement a digital circuit to add two 4-bit binary numbers and one carry input. The design must generate a 4-bit sum output and produce one carry output as well as ensure carry-propagation between each Full Adder stage is correct.

# Theory
A Ripple Carry Adder is built by cascading multiple Full Adders.

Each Full Adder performs the following operation:

A + B + Carry Input

Outputs:

- Sum
- Carry Output

The Carry Output of one Full Adder becomes the Carry Input of the next Full Adder.

For a 4-bit adder:

Cin → FA0 → FA1 → FA2 → FA3 → Cout

Since the carry travels through every Full Adder one by one, it is known as a Ripple Carry Adder.

# Working Principle
1. The first Full Adder combines A0, B0 and Cin.
2. Produces Sum0 and Carry1.
3. Carry1 is connected to the second Full Adder.
4. The second Full Adder is the sum of A1, B1 and Carry1.
5. This process is repeated in all 4 Full Adders.
6. The fourth Full Adder produces Sum3 and the last Carry Output.

The carry “carries” from one stage to the next until it is formed in the final output.

| A | B | Cin | Sum | Cout |
| - | - | --- | --- | ---- |
| 0 | 0 | 0   | 0   | 0    |
| 0 | 0 | 1   | 1   | 0    |
| 0 | 1 | 0   | 1   | 0    |
| 0 | 1 | 1   | 0   | 1    |
| 1 | 0 | 0   | 1   | 0    |
| 1 | 0 | 1   | 0   | 1    |
| 1 | 1 | 0   | 0   | 1    |
| 1 | 1 | 1   | 1   | 1    |

# Verilog HDL Code
## Full Adder Module
```verilog
module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);

endmodule
```
---

## 4-Bit Ripple Carry Adder
```verilog
module ripple_carry_adder_4bit(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] Sum,
    output Cout
);

wire c1, c2, c3;

full_adder FA0(
    .a(A[0]),
    .b(B[0]),
    .cin(Cin),
    .sum(Sum[0]),
    .cout(c1)
);

full_adder FA1(
    .a(A[1]),
    .b(B[1]),
    .cin(c1),
    .sum(Sum[1]),
    .cout(c2)
);

full_adder FA2(
    .a(A[2]),
    .b(B[2]),
    .cin(c2),
    .sum(Sum[2]),
    .cout(c3)
);

full_adder FA3(
    .a(A[3]),
    .b(B[3]),
    .cin(c3),
    .sum(Sum[3]),
    .cout(Cout)
);

endmodule
```
---

## Testbench
```verilog
`timescale 1ns/1ps

module ripple_carry_adder_4bit_tb;

reg [3:0] A;
reg [3:0] B;
reg Cin;

wire [3:0] Sum;
wire Cout;

ripple_carry_adder_4bit uut(
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
);

initial begin

A=4'b0000; B=4'b0000; Cin=0; #10;
A=4'b0001; B=4'b0001; Cin=0; #10;
A=4'b0010; B=4'b0011; Cin=0; #10;
A=4'b0101; B=4'b0011; Cin=0; #10;
A=4'b1111; B=4'b0001; Cin=0; #10;
A=4'b1010; B=4'b0101; Cin=1; #10;
A=4'b1111; B=4'b1111; Cin=0; #10;

$finish;

end

endmodule
```
---

# Advantages
- Simple architecture
- Easy to design
- Low hardware complexity
- Easy debugging
- FPGA implementation friendly
- Modular design
- Minimal resource utilization
- Ideal for beginners
- Good for educational purposes


# Possible improvements include:

- Carry Lookahead Adder (CLA)
- Carry Skip Adder
- Carry Select Adder
- Carry Save Adder
- Another option is Parallel Prefix Adders (Kogge–Stone, Brent–Kung).
- FPGA optimization
- Low-power VLSI implementation
- High-speed ASIC implementation
- Pipelined arithmetic units

# Learning Outcomes

By the end of this project, you will have developed an understanding of:

- Binary addition
- Half Adder operation
- Full Adder operation
- Ripple Carry Adder architecture
- Carry propagation concept
- Verilog HDL programming
- Modular hardware design
- Combinational logic circuits
- Testbench creation
- Functional simulation
- Timing analysis
- Explain basic concepts of digital design using FPGAs.Grasp the basics of digital design on FPGAs.

# Conclusion

The 4-bit Ripple Carry Adder is a one of the simplest arithmetic circuits in digital electronics. Its carry propagation delay is a limitation for large bit-width operations, but its simplicity, modularity and ease of implementation make it an ideal vehicle with which to learn digital design concepts. The use of the RCA in Verilog HDL gives hands-on experience with hardware description languages, simulation, and combinational circuit design which will be useful for future advanced VLSI, FPGA, and digital system design.
