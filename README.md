# 4-Bit Ripple Carry Adder — Verilog HDL

![Language](https://img.shields.io/badge/HDL-Verilog-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-simulated-brightgreen)

A structural Verilog implementation of a 4-bit Ripple Carry Adder (RCA), built by cascading four 1-bit Full Adders. Includes a self-checking testbench and simulation results from ModelSim.

## Overview

A Ripple Carry Adder adds two n-bit binary numbers by chaining single-bit Full Adders, where the carry-out of each stage feeds the carry-in of the next:

```
Cin → FA0 → FA1 → FA2 → FA3 → Cout
```

This project implements, simulates, and verifies a 4-bit RCA in Verilog HDL, and is structured so it can be synthesized on FPGA boards using AMD Vivado or Intel Quartus Prime.

## Repository Structure

```
├── 4-Bit Ripple Carry Adde.v     # Full Adder + Ripple Carry Adder modules
├── testbench.v                    # Testbench with 7 stimulus vectors
├── simulation screenshot.png      # ModelSim waveform & transcript
├── LICENSE
└── README.md
```

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

Top-level module port list ([full source](./4-Bit%20Ripple%20Carry%20Adde.v)):

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
vlog "4-Bit Ripple Carry Adde.v" testbench.v
vsim work.ripple_carry_adder_4bit_tb
add wave *
run 100 ns
```

### Icarus Verilog (open source, cross-platform)
```bash
iverilog -o rca_sim "4-Bit Ripple Carry Adde.v" testbench.v
vvp rca_sim
```

### Vivado / Quartus
Add both `.v` files to a new project, set `ripple_carry_adder_4bit` as the top module for synthesis, or the testbench as the top module for behavioral simulation.

## Results

Simulated in ModelSim across 7 test vectors covering zero inputs, simple addition, mid-chain carry generation, and all-ones overflow. All outputs matched expected binary addition results.

![Simulation waveform](./simulation%20screenshot.png)

## Advantages & Limitations

**Advantages:** simple, modular, easy to debug, low resource usage, ideal for learning HDL and combinational design.

**Limitation:** carry propagation delay grows linearly with bit-width, making the RCA unsuitable for high-speed, wide-word arithmetic. Faster alternatives: Carry Lookahead, Carry Skip, Carry Select, Carry Save, and Parallel Prefix (Kogge–Stone, Brent–Kung) adders.

## License

Licensed under the [MIT License](./LICENSE).

## Author

**Ayush Sikarwar**
GitHub: [@ayushsikarwar3](https://github.com/ayushsikarwar3)
