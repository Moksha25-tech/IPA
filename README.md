# 64-bit Sequential RISC-V Processor (RV64I)

A custom 64-bit Sequential (Non-Pipelined) RISC-V Processor implemented in Verilog HDL and verified using iVerilog and GTKWave.

## Overview

This project implements a complete RV64I processor capable of executing instructions sequentially through the classic processor stages:

- Instruction Fetch (IF)
- Instruction Decode (ID)
- Execute (EX)
- Memory Access (MEM)
- Write Back (WB)

The processor follows a modular design where each component was independently developed, tested, and integrated into the final processor.

---

## Features

### Supported Instructions

#### Arithmetic
- ADD
- SUB
- ADDI

#### Logical
- AND
- OR

#### Memory Operations
- LD
- SD

#### Control Flow
- BEQ

### Architecture Highlights

- 64-bit Datapath
- RV64I ISA Support
- Big-Endian Memory Organization
- Byte-Addressable Instruction Memory
- Byte-Addressable Data Memory
- Modular Verilog Design
- Independent Module Verification
- End-to-End Processor Integration

---

## Processor Components

| Module | Description |
|----------|------------|
| Program Counter | Maintains current instruction address |
| Instruction Memory | Stores executable instructions |
| Register File | 32 × 64-bit registers |
| Control Unit | Generates datapath control signals |
| Immediate Generator | Sign-extends immediates |
| ALU Control | Decodes ALU operations |
| ALU | Performs arithmetic and logical operations |
| Data Memory | Supports load/store instructions |
| Multiplexers | Datapath routing |
| CLA Adders | Fast arithmetic operations |

---

## Project Structure

```text
IPA/
├── README.md
├── Team33_Report.pdf
│
├── src/
│   ├── processor.v
│   ├── pc.v
│   ├── control_unit.v
│   ├── alu_control.v
│   ├── imm_gen.v
│   ├── instruction_mem.v
│   ├── data_mem.v
│   ├── register_file.v
│
├── testbench/
│   ├── seq_tb.v
│   └── individual_testbenches/
│
├── programs/
│   ├── fibonacci_instructions.txt
│   ├── fibonacci_instructions_exp.txt
│   ├── sum_instructions.txt
│   └── sum_instructions_exp.txt
│
└── docs/
    └── waveforms/
```

---

## Tools Used

- Verilog HDL
- iVerilog
- GTKWave
- RISC-V RV64I ISA

---

## Running the Project

### Compile

```bash
iverilog -o processor *.v
```

### Run

```bash
vvp processor
```

### View Waveforms

```bash
gtkwave dump.vcd
```

---

## Verification Programs

### Sum of First N Numbers

The processor executes a RISC-V program to compute:

```text
1 + 2 + 3 + ... + N
```

Example:

```text
N = 30
Sum = 465
```

### Fibonacci Sequence

The processor generates and stores Fibonacci numbers in memory:

```text
0
1
1
2
3
5
8
13
```

The values are then loaded back into registers for verification.

---

## Learning Outcomes

- Computer Architecture
- RISC-V ISA
- Datapath Design
- Control Logic Design
- Verilog HDL
- Digital Design Verification
- Processor Integration
- Simulation & Debugging

---

## Future Improvements

- 5-Stage Pipelined Processor
- Hazard Detection Unit
- Data Forwarding
- Branch Prediction
- Cache Integration
- RV64IM Extension Support

---

## Team

- Moksha Choksi
- Gauri Krishnan
- Dhanika Kothari

---

## License

This project was developed for educational and academic purposes.
