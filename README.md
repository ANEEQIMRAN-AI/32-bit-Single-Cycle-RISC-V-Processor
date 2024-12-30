# RISC-V 32-Bit Single-Cycle Processor

## Project Overview
This project presents a custom implementation of a RISC-V 32-bit single-cycle processor designed to execute a variety of instructions from the RISC-V ISA. The processor focuses on simplicity and efficiency, making it suitable for embedded systems and academic exploration.

## Key Features
- **Single-Cycle Execution:** Ensures every instruction completes in one clock cycle, simplifying the control logic.
- **Extended RISC-V ISA Support:** Implements multiple instruction types including arithmetic, logical, memory access, and branch operations.
- **SystemVerilog Implementation:** Optimized for synthesis and simulation.
- **Comprehensive Testbench:** Includes module-specific and system-level testing environments.

## Repository Layout
```
├── src
│   ├── datapath.sv         # Datapath components and interconnections
│   ├── control_unit.sv     # Logic for instruction decoding and control signals
│   ├── alu.sv              # Core arithmetic and logical operations
│   ├── register_file.sv    # Storage for general-purpose registers
│   ├── memory.sv           # Instruction and data memory modules
├── testbench
│   ├── processor_tb.sv     # System-level testbench for the processor
│   ├── alu_tb.sv           # Unit test for the ALU
│   ├── memory_tb.sv        # Unit test for memory operations
├── docs
│   └── architecture_diagram.png  # Processor architecture diagram
├── README.md               # Documentation (this file)
└── LICENSE                 # License details
```

## How to Use

### Prerequisites
- **Hardware Description Language Tools:** A SystemVerilog simulator like ModelSim, QuestaSim, or Synopsys VCS.
- **RISC-V Toolchain:** To assemble and convert RISC-V programs into executable formats.

### Steps to Simulate
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/riscv-single-cycle-processor.git
   cd riscv-single-cycle-processor
   ```
2. Compile the SystemVerilog source files located in the `src` directory.
3. Run the provided testbenches in the `testbench` directory to verify module functionality.
4. Modify and test custom RISC-V programs as needed.

## Design Highlights
- **Datapath:** Implements program counter, instruction memory, register file, ALU, and data memory.
- **Control Unit:** Decodes opcodes and generates control signals for execution.
- **Memory Architecture:** Supports separate instruction and data memories for Harvard architecture simulation.

### Supported Instructions
| Instruction Type | Examples              |
|------------------|-----------------------|
| R-Type           | ADD, SUB, AND, OR     |
| I-Type           | ADDI, LOAD            |
| S-Type           | STORE                 |
| B-Type           | BEQ, BNE ,ETC         |
| U-Type           | LUI, AUIPC            |
| J-Type           | JAL JALR              |

## Testing and Validation
- **Unit Testing:** Each module has its own testbench to ensure correctness.
- **System Testing:** The processor is validated with assembly programs for functional verification.
- **Custom Benchmarks:** Supports the execution of RISC-V assembly programs to evaluate performance and accuracy.

## Contribution Guidelines
We welcome contributions to enhance the functionality and design of this processor. To contribute:
1. Fork this repository.
2. Create a branch for your feature (`git checkout -b feature-name`).
3. Commit your changes (`git commit -m 'Describe your feature'`).
4. Push to your branch (`git push origin feature-name`).
5. Open a pull request for review.

## License
This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.

## Contact
For any queries or feedback:
- **Name:** Aneeq Imran
- **Email:** aneeqimran.ai@gmail.com

