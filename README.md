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

