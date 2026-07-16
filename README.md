# 4-Bit Ripple Carry Adder — Verilog HDL

![Language](https://img.shields.io/badge/HDL-Verilog-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-simulated-brightgreen)

A structural Verilog implementation of a 4-bit Ripple Carry Adder (RCA), built by cascading four 1-bit Full Adders. Includes a self-checking testbench (verified against a reference `A + B + Cin` model) and simulation results.

## Overview

A Ripple Carry Adder adds two n-bit binary numbers by chaining single-bit Full Adders, where the carry-out of each stage feeds the carry-in of the next:

```
Cin → FA0 → FA1 → FA2 → FA3 → Cout
```

This project implements, simulates, and verifies a 4-bit RCA in Verilog HDL, and is structured so it can be synthesized on FPGA boards using AMD Vivado or Intel Quartus Prime.

## Repository Structure

```
├── full_adder.v                   # 1-bit Full Adder (sum/carry logic)
├── ripple_carry_adder_4bit.v      # Top-level 4-bit RCA (instantiates 4x full_adder)
├── testbench.v                    # Self-checking testbench (7 vectors, PASS/FAIL report)
├── simulation screenshot.png      # Simulation waveform & transcript
├── LICENSE
└── README.md
```

> **Note:** the design is split into `full_adder.v` and `ripple_carry_adder_4bit.v` so it compiles standalone — `ripple_carry_adder_4bit` instantiates `full_adder`, so both files must be compiled together.

## Design

Each Full Adder computes:

| A | B | Cin | Sum | Cout |
|---|---|-----|-----|------|
| 0 | 0 | 0   | 0   | 0    |
| 0 | 0 | 1   | 1   | 0    |
| 0 | 1 | 0   | 1   | 0    |
| 0 | 1 | 1   | 0   | 1    |
| 1 | 0 | 0   | 1   | 0    |
| 1 | 0 | 1   | 0   | 1    |
| 1 | 1 | 0   | 0   | 1    |
| 1 | 1 | 1   | 1   | 1    |

`Sum = A ⊕ B ⊕ Cin`, `Cout = (A·B) + (B·Cin) + (A·Cin)`

Top-level module port list ([full source](./ripple_carry_adder_4bit.v)):

```verilog
module ripple_carry_adder_4bit(
    input  [3:0] A,
    input  [3:0] B,
    input        Cin,
    output [3:0] Sum,
    output       Cout
);
```

## How to Run

### ModelSim / QuestaSim
```bash
vlog full_adder.v ripple_carry_adder_4bit.v testbench.v
vsim work.ripple_carry_adder_4bit_tb
add wave *
run 100 ns
```

### Icarus Verilog (open source, cross-platform)
```bash
iverilog -o rca_sim full_adder.v ripple_carry_adder_4bit.v testbench.v
vvp rca_sim
```

### Vivado / Quartus
Add all three `.v` files to a new project. Set `ripple_carry_adder_4bit` as the top module for synthesis, or `ripple_carry_adder_4bit_tb` as the top module for behavioral simulation.

## Results

The testbench applies 7 stimulus vectors (zero inputs, simple addition, mid-chain carry generation, and an all-ones overflow case) and compares each output against a reference `A + B + Cin` calculation, printing `PASS`/`FAIL` per vector and a final `ALL TESTS PASSED` summary. Verified with Icarus Verilog — all 7 vectors pass:

```
PASS: A=0000 B=0000 Cin=0 | Sum=0000 Cout=0
PASS: A=0001 B=0001 Cin=0 | Sum=0010 Cout=0
PASS: A=0010 B=0011 Cin=0 | Sum=0101 Cout=0
PASS: A=0101 B=0011 Cin=0 | Sum=1000 Cout=0
PASS: A=1111 B=0001 Cin=0 | Sum=0000 Cout=1
PASS: A=1010 B=0101 Cin=1 | Sum=0000 Cout=1
PASS: A=1111 B=1111 Cin=0 | Sum=1110 Cout=1
ALL TESTS PASSED
```

![Simulation waveform](./simulation%20screenshot.png)

> **Note:** the screenshot above is from an earlier version of this design (different file/module/signal names). Re-run the steps above and swap in a fresh waveform screenshot so it matches the current source exactly.

## Advantages & Limitations

**Advantages:** simple, modular, easy to debug, low resource usage, ideal for learning HDL and combinational design.

**Limitation:** carry propagation delay grows linearly with bit-width, making the RCA unsuitable for high-speed, wide-word arithmetic. Faster alternatives: Carry Lookahead, Carry Skip, Carry Select, Carry Save, and Parallel Prefix (Kogge–Stone, Brent–Kung) adders.

## License

Licensed under the [MIT License](./LICENSE).

## Author

**Ayush Sikarwar**
GitHub: [@ayushsikarwar3](https://github.com/ayushsikarwar3)
